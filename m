From: Julien.Soula@lifl.fr
Subject: Re: autofs4 patches for 2.6 kernel
Date: Fri, 9 Apr 2004 22:46:04 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040409204604.GB4007@foudroyante.lifl.fr>
References: <Pine.LNX.4.58.0404071952170.4948@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============67825274032849725=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0404071952170.4948@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs mailing list <autofs@linux.kernel.org>


--===============67825274032849725==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2004 at 08:04:18PM +0800, Ian Kent wrote:
>=20
> Hi all,
>=20
> Some progress on getting the autofs4 patches into the kernel tree.
>=20
> Could anyone that is able to test within a 2.6 envronment please test thi=
s=20
> as much as possible and feed back the results.
>=20
> There are bound to be problems so it would be good to be pro-active.

It's not really related to kernel side but it seems that the variables
on command line (-Dtoto=3Dtata) are not passed throught submount, at
least for direct mount.

I test it with automount version 4.1.2

--=20
Julien


--3uo+9/B/ebqu+fSQ
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIKagYJKoZIhvcNAQcCoIIKWzCCClcCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
CB0wggSoMIIDkKADAgECAgINmDANBgkqhkiG9w0BAQQFADA0MQswCQYDVQQGEwJGUjENMAsG
A1UEChMEQ05SUzEWMBQGA1UEAxMNQ05SUy1TdGFuZGFyZDAeFw0wNDAzMzEwODAxNTRaFw0w
NTAzMzEwODAxNTRaMGoxCzAJBgNVBAYTAkZSMQ0wCwYDVQQKEwRDTlJTMRAwDgYDVQQLEwdV
TVI4MDIyMRUwEwYDVQQDEwxKdWxpZW4gU291bGExIzAhBgkqhkiG9w0BCQEWFEp1bGllbi5T
b3VsYUBsaWZsLmZyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA10nFjenT03pZ
EkXAJLn4sZ4Fr+Xfx/a1RPXGFsA+WK5xl3OsXiut8X+2oTsIuPEHhyfdVFM+xz+f+G5MJIQp
yODYXbe1mvDw+I1BIwuQoQZuFxrvxGxi7uzIUUgtkiRIolos9Jut10P1F9agJThuAt/Fn4IV
/a+LQUkHcac4984t/M33Uex5YJvNC1sOYO3QN+Xm/CIGf5rvWDS2hjLBkkQ5wLHM0aRC+ppK
zI3CO7RT2s75KGpF9qnvj5z6Uk13/pRpEyIWTN8Ktt9MmMO9yGCKSCEqPAd6WpgvngMaud5t
4f5PkvXwaHS7Rc97csfj4ugpg/R/Bv7BJ1sdKzSTlQIDAQABo4IBjDCCAYgwDAYDVR0TAQH/
BAIwADARBglghkgBhvhCAQEEBAMCBLAwDgYDVR0PAQH/BAQDAgXgMHgGCWCGSAGG+EIBDQRr
FmlDZXJ0aWZpY2F0IENOUlMtU3RhbmRhcmQuIFBvdXIgdG91dGUgaW5mb3JtYXRpb24gc2Ug
cmVwb3J0ZXIg4CBodHRwOi8vaWdjLnNlcnZpY2VzLmNucnMuZnIvQ05SUy1TdGFuZGFyZC8w
HQYDVR0OBBYEFFbWVGaSroKTcSaVDqg+0qUd/nyuMFMGA1UdIwRMMEqAFGdZpeUHdEkD7wXP
zC6kGNUQyJ48oS+kLTArMQswCQYDVQQGEwJGUjENMAsGA1UEChMEQ05SUzENMAsGA1UEAxME
Q05SU4IBAjAfBgNVHREEGDAWgRRKdWxpZW4uU291bGFAbGlmbC5mcjBGBgNVHR8EPzA9MDug
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
udLyxARNstKUqlpfnGw9rcMBPWJhlFKM

--3uo+9/B/ebqu+fSQ--


--===============67825274032849725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============67825274032849725==--

