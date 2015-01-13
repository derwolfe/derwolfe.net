import os

import pem

from twisted.application.service import Application

from twisted.application.internet import (
    TCPServer,
    SSLServer
)

from twisted.python.filepath import FilePath

from twisted.web.server import Site
from twisted.web.static import File
from twisted.web.resource import Resource
from twisted.web.util import redirectTo

from twisted.internet.ssl import (
    CertificateOptions, Certificate, PrivateCertificate
)

SECURE_PORT = os.getenv('SECURE_PORT')

CERT_DIR = FilePath('/keys')

key = pem.parse_file(CERT_DIR.child('privkey.pem').path)[0]
cert = pem.parse_file(CERT_DIR.child('ssl.crt').path)[0]
chain = pem.parse_file(CERT_DIR.child('chain.pem').path)[0]

cert = PrivateCertificate.loadPEM(str(key) + '\n' + str(cert))
chainCert = Certificate.loadPEM(str(chain))

ctxFactory = CertificateOptions(
      privateKey=cert.privateKey.original,
      certificate=cert.original,
      extraCertChain=[chainCert.original],
)


class RedirectResource(Resource):
    isLeaf = True

    def render(self, request):
        host = request.requestHeaders.getRawHeaders('host')[0].split(':', 1)[0]
        port = ''
        if SECURE_PORT is not None:
            port = ':{0}'.format(SECURE_PORT)
        return redirectTo(
            'https://{0}{1}{2}'.format(host, port, request.uri),
            request
        )


class HSTSResource(Resource):
    def __init__(self, wrapped):
        self._wrapped = wrapped

    def getChildWithDefault(self, name, request):
        request.responseHeaders.addRawHeader(
            'Strict-Transport-Security',
            'max-age=31536000; includeSubDomains'
        )
        return self._wrapped.getChildWithDefault(name, request)


application = Application("A website")

plainSite = Site(RedirectResource())
plainSite.displayTracebacks = False

plainService = TCPServer(8080, plainSite)
plainService.setServiceParent(application)

secureSite = Site(HSTSResource(File('/site')))
secureSite.displayTracebacks = False

secureService = SSLServer(4443, secureSite, ctxFactory)
secureService.setServiceParent(application)