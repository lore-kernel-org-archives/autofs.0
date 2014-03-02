From: Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: "Too many levels of symbolic links"
Date: Sun, 02 Mar 2014 15:55:56 +0100
Message-ID: <5313467C.9080102@molgen.mpg.de>
References: <1391145206.2486.25.camel@perseus.fritz.box>	 <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>	 <530484B7.6030305@molgen.mpg.de>	 <1392896501.2508.16.camel@perseus.fritz.box>	 <1392898704.2508.26.camel@perseus.fritz.box>	 <530625D0.7020808@molgen.mpg.de>	 <1392946952.2495.3.camel@perseus.fritz.box>	 <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de>	 <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>	 <1393726942.9725.5.camel@perseus.fritz.box> <1393744241.9725.16.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms040507080401020204040505"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1393744241.9725.16.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, Alexander Viro <aviro@redhat.com>
Cc: autofs <autofs@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms040507080401020204040505
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Am 02.03.2014 08:10, schrieb Ian Kent:
> On Sun, 2014-03-02 at 10:22 +0800, Ian Kent wrote:
>> On Fri, 2014-02-28 at 08:29 -0500, Alexander Viro wrote:
>>> On Fri, Feb 28, 2014 at 01:12:58PM +0100, Donald Buczek wrote:
>>>
>>>> Obviously, "cleared mounted on dentry" is missing.
>>>>
>>>> It looks like we enter put_mountpoint() but don't get to
>>>> dentry->d_flags &=3D ~DCACHE_MOUNTED;
>>>>
>>>> mp->m_count is not zero probably.
>>>>
>>>> What does it mean? The mount is still locked but not in the mount ha=
sh?
>>> No, it means that something else is mounted on the same dentry (in an=
other
>>> part of mount tree, obviously).
>>>
>>> If you mount the same fs on two different mountpoints, e.g.
>>> mount /dev/sda1 /mnt
>>> mount /dev/sda1 /tmp/foo
>>> you will have the same dentries seen in two places.  Now,
>>> mount /dev/sdb11 /mnt/a
>>> mount /dev/sdc5 /tmp/foo/a
>>>
>>> and you've got two different filesystems mounted on two different pla=
ces
>>> (/mnt/a and /tmp/foo/a).  These two places have different vfsmounts,
>>> but the same dentry.  struct mountpoint is associated with dentry, so=

>>> it's also the same for both.  And it serves as a mountpoint for two
>>> vfsmounts - one for fs from sdb11, another for fs from sdc5.
>>>
>>> Now umount /mnt/a; one of those two vfsmounts is gone now.  struct mo=
untpoint
>>> survives, of course, and dentry is *still* a mountpoint.  sdc5 is sti=
ll
>>> mounted on /tmp/foo/a, after all...
> Good example but for autofs file systems doesn't this amount to saying
> its been bound somewhere else?
>
> Illegal as far as autofs is concerned because an autofs mount is
> strictly associated with a path defined by its map.
>
> And, yes, bind mounting an autofs file system elsewhere isn't vetoed by=

> the kernel.
>
> This makes be start thinking about implications wrt. containers ....
>
>> Ahh, right ... I'll need to think about my use (misuse) of
>> d_mountpoint().
> So maybe I don't need to worry about this just yet.

I think you should, because exactly this is the bug.
d_mountpoint(dentry) just says, that we have a struct mountpoint for the =

dentry. It does not say, that the path is mounted in the current=20
namespace. The struct mountpoint might exists, because the path is=20
mounted in other namespaces but not ours.

The problem at our site is clear now:

We have only one service with PrivateTmp=3Dyes which is colord.service.=20
And here is the missing mount:

> root:kasslerbraten:/lib/systemd/system/# ps -Af|fgrep colord
> root      7670     1  0 Feb28 ?        00:00:00 /usr/lib/colord/colord
> root      7897  7329  0 14:46 pts/8    00:00:00 fgrep colord
> root:kasslerbraten:/lib/systemd/system/# cat /proc/7670/mounts|grep=20
> mariux32
> pille:/amd/pille/1/project/mariux32 /project/mariux32 nfs=20
> rw,nosuid,relatime,vers=3D3,rsize=3D524288,wsize=3D524288,namlen=3D255,=
hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mountaddr=3D141.14.28.=
250,mountvers=3D3,mountport=3D56263,mountproto=3Dudp,local_lock=3Dnone,ad=
dr=3D141.14.28.250=20
> 0 0

colord.service is dbus-started. So it is started quiet randomly and=20
depending on user usage pattern, mostly but not exclusively on=20
workstations. That is exactly how we've seen the bug to appear.

When the services is started, systemd uses unshare(CLONE_NEWNS) to clone =

the namespace. This new namespace inherits existing mounts, including=20
automounted ones.
These mounts might eventually expire at a later time. When this occurs,=20
they are dismounted from the automount daemons namespace, which is the=20
global, pid 1 namespace. But because they are still mounted in another=20
namespace, the dentry stays flagged as DCACHE_MOUNTED, which prevents=20
autofs to remount it on access. The mount, however, just exists in=20
another namespace and is useless for anybody else.

Final prove, that this is the true story:

> root:kasslerbraten:/lib/systemd/system/# ls /project/mariux32
> ls: cannot open directory /project/mariux32: Too many levels of=20
> symbolic links
> root:kasslerbraten:/lib/systemd/system/# kill -9 7670
> root:kasslerbraten:/lib/systemd/system/# ls /project/mariux32
> beeroot  home  i686  svnroot
> root:kasslerbraten:/lib/systemd/system/#

Of course, I can easily work around that in our environment (eg. just=20
remove PrivateTmp=3Dyes from the service). So I'm pretty sure, it will=20
work for me now.
The bug, however, is in autofs. systemd is doing perfectly legal=20
user-mode things.

Perhaps autofs should use lookup_mnt()  to decide along this pattern:

if ( dentry->d_flags & DCACHE_MOUNTED && lookup_mnt(path)  ) {
   /* mounted */
} else {
   /* not mounted */
}

That doesn't solve the problem, however, that mounts cloned by a=20
unshare(CLONE_NEWNS) would never expire. Also there is another bug=20
somewhere, because I see, that the mount, visible to the=20
/usr/lib/colord/colord process was logged as "unmounted" in the nfs=20
server when it expired in the global namespace. So I doubt it would be=20
working even for that process. So possibly automounted mounts shouldn't=20
be cloned at all? Together with chroot or pivot_root the sematics would=20
be more than unclear anyway. Your problem now :-)

Thanks for you help with this!

Regards
   Donald

--=20
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433



--------------ms040507080401020204040505
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIOKjCC
BCEwggMJoAMCAQICAgDHMA0GCSqGSIb3DQEBBQUAMHExCzAJBgNVBAYTAkRFMRwwGgYDVQQK
ExNEZXV0c2NoZSBUZWxla29tIEFHMR8wHQYDVQQLExZULVRlbGVTZWMgVHJ1c3QgQ2VudGVy
MSMwIQYDVQQDExpEZXV0c2NoZSBUZWxla29tIFJvb3QgQ0EgMjAeFw0wNjEyMTkxMDI5MDBa
Fw0xOTA2MzAyMzU5MDBaMFoxCzAJBgNVBAYTAkRFMRMwEQYDVQQKEwpERk4tVmVyZWluMRAw
DgYDVQQLEwdERk4tUEtJMSQwIgYDVQQDExtERk4tVmVyZWluIFBDQSBHbG9iYWwgLSBHMDEw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDpm8NnhfkNrvWNVMOWUDU9YuluTO2U
1wBblSJ01CDrNI/W7MAxBAuZgeKmFNJSoCgjhIt0iQReW+DieMF4yxbLKDU5ey2QRdDtoAB6
fL9KDhsAw4bpXCsxEXsM84IkQ4wcOItqaACa7txPeKvSxhObdq3u3ibo7wGvdA/BCaL2a869
080UME/15eOkyGKbghoDJzANAmVgTe3RCSMqljVYJ9N2xnG2kB3E7f81hn1vM7PbD8URwoqD
oZRdQWvY0hD1TP3KUazZve+Sg7va64sWVlZDz+HVEz2mHycwzUlU28kTNJpxdcVs6qcLmPkh
nSevPqM5OUhqjK3JmfvDEvK9AgMBAAGjgdkwgdYwcAYDVR0fBGkwZzBloGOgYYZfaHR0cDov
L3BraS50ZWxlc2VjLmRlL2NnaS1iaW4vc2VydmljZS9hZl9Eb3dubG9hZEFSTC5jcmw/LWNy
bF9mb3JtYXQ9WF81MDkmLWlzc3Vlcj1EVF9ST09UX0NBXzIwHQYDVR0OBBYEFEm3xs/oPR9/
6kR7Eyn38QpwPt5kMB8GA1UdIwQYMBaAFDHDeRu69VPXF+CJei0XbAqzK50zMA4GA1UdDwEB
/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgECMA0GCSqGSIb3DQEBBQUAA4IBAQA74Vp3wEgX
3KkY7IGvWonwvSiSpspZGBJw7Cjy565/lizn8l0ZMfYTK3S9vYCyufdnyTmieTvhERHua3iR
M347XyYndVNljjNj7s9zw7CSI0khUHUjoR8Y4pSFPT8z6XcgjaK95qGFKUD2P3MyWA0Ja6ba
hWzAP7uNZmRWJE6uDT8yNQFb6YyC2XJZT7GGhfF0hVblw/hc843uR7NTBXDn5U2KaYMo4RMJ
hp5eyOpYHgwf+aTUWgRo/Sg+iwK2WLX2oSw3VwBnqyNojWOl75lrXP1LVvarQIc01BGSbOyH
xQoLBzNytG8MHVQs2FHHzL8w00Ny8TK/jM5JY6gA9/IcMIIE5zCCA8+gAwIBAgIECs6x2DAN
BgkqhkiG9w0BAQUFADBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZOLVZlcmVpbjEQMA4G
A1UECxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xvYmFsIC0gRzAxMB4X
DTA3MDczMTEzMDgyNVoXDTE5MDYzMDAwMDAwMFowXjELMAkGA1UEBhMCREUxIDAeBgNVBAoT
F01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MQ8wDQYDVQQDEwZNUEcgQ0ExHDAaBgkqhkiG9w0B
CQEWDW1wZy1jYUBtcGcuZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDYUXKe
oNTLgkGwbani4rlua5jzlzISfHnaj/5qS+mojQqA/eYa0bGucylV5hyQuyJz7d4gRckdhMDV
8DZIxERUIsFlXFj6HGHjaZjlhIHbo4S12GjLhTH5YZ37O7MHVw0L/JhhzUIxESM1ZfRT/xLq
hz2idJYjT98W9OFvzPgT0yrdieMzkLUz5X/fpY8MuyYBgxnddBJRw6ZtlhdCml4F8Q35pSb8
J2qANiwuJVu3WCTgL/ydo3eA8vDieMMZ7O+L1wAnCzBbHAjJ5H6xU1B7mlwmu7V3pToKPgcW
mlO0HcTpa68McNTGGiY8pO0/Rn1fXkqDYf8z0lPdWUWxbM1RAgMBAAGjggGvMIIBqzASBgNV
HRMBAf8ECDAGAQH/AgEBMAsGA1UdDwQEAwIBBjAdBgNVHQ4EFgQUAtYebgmrv1hlpwo8SDNh
0c59w1swHwYDVR0jBBgwFoAUSbfGz+g9H3/qRHsTKffxCnA+3mQwGAYDVR0RBBEwD4ENbXBn
LWNhQG1wZy5kZTCBiAYDVR0fBIGAMH4wPaA7oDmGN2h0dHA6Ly9jZHAxLnBjYS5kZm4uZGUv
Z2xvYmFsLXJvb3QtY2EvcHViL2NybC9jYWNybC5jcmwwPaA7oDmGN2h0dHA6Ly9jZHAyLnBj
YS5kZm4uZGUvZ2xvYmFsLXJvb3QtY2EvcHViL2NybC9jYWNybC5jcmwwgaIGCCsGAQUFBwEB
BIGVMIGSMEcGCCsGAQUFBzAChjtodHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290
LWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBHBggrBgEFBQcwAoY7aHR0cDovL2NkcDIucGNh
LmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcN
AQEFBQADggEBABtJz5i/SGqQOficdRUN6myFVmVelCYgkGT+zX7frnBRJFoVVafXolstZdVB
7ZpH9FAcqj8O6FTZyhAANwh3+Y1D6xYBWTB7mQGy0lUoUL+j0msZjaMvyj/2LCQp7cKB5vA4
h6Ntq5BN5MPcaRhunzjJey/i+J/3jMdG7KpufV47Gl0E8ky9lDegaM7SToG4IOQKwv1wsnuH
oxoGLRewxO7FmYd9uq9f4L2mHtqgq+vibT1DeehT0HGPnrjjd8NK6g2TvZwirwjydbGs7szB
5oxDm/pfWoJxYzO68HKTiVBlmaWMLpGw4/UsLE+5xJHpvNXfkYCQ3T+k99KBUZuIpKwwggUW
MIID/qADAgECAgcTo68+b/5oMA0GCSqGSIb3DQEBBQUAMF4xCzAJBgNVBAYTAkRFMSAwHgYD
VQQKExdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEPMA0GA1UEAxMGTVBHIENBMRwwGgYJKoZI
hvcNAQkBFg1tcGctY2FAbXBnLmRlMB4XDTEyMDQxMDEzMTIxNFoXDTE1MDQxMDEzMTIxNFow
gYoxCzAJBgNVBAYTAkRFMSAwHgYDVQQKExdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDE0MDIG
A1UECxMrTWF4LVBsYW5jay1JbnN0aXR1dCBmdWVyIG1vbGVrdWxhcmUgR2VuZXRpazELMAkG
A1UECxMCSVQxFjAUBgNVBAMTDURvbmFsZCBCdWN6ZWswggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQC8AkX5++7fOB5qItwhRS7gQ6VJthfPItK8AMTlGeyuqHztDM4us3VKll9t
Z7HybeXypqTt38JNrU56RnIqRwk+ajvNngk0Z+72eLUXH+TydvemBJ4fvnkIYtOgO7PZfKTy
iDSCo2tt/PuqnMlacXhCOWrgljhYhZgaPeecoDC+7EA3S3IKVJNBPxT1VtwRb3M691Igu2Th
yar3F7BkeyimbJ8UKHLpeHX1UvUwfdO0Geem7tkC5JPHlhwMb0Lpr6VImyl6a1CW88yGP5s2
sp1Bnr31ZLISjwq3VCRggzjPcjZPo1bMXzg2yAsh3BUp3ljYYTxJHe2u/LGzsJoVB1crAgMB
AAGjggGqMIIBpjAJBgNVHRMEAjAAMAsGA1UdDwQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFEUP5hp3anavBSte9vwsqlJ/LpMSMB8GA1UdIwQYMBaA
FALWHm4Jq79YZacKPEgzYdHOfcNbMB8GA1UdEQQYMBaBFGJ1Y3pla0Btb2xnZW4ubXBnLmRl
MHcGA1UdHwRwMG4wNaAzoDGGL2h0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWNhL3B1Yi9j
cmwvY2FjcmwuY3JsMDWgM6Axhi9odHRwOi8vY2RwMi5wY2EuZGZuLmRlL21wZy1jYS9wdWIv
Y3JsL2NhY3JsLmNybDCBkgYIKwYBBQUHAQEEgYUwgYIwPwYIKwYBBQUHMAKGM2h0dHA6Ly9j
ZHAxLnBjYS5kZm4uZGUvbXBnLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDA/BggrBgEFBQcw
AoYzaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0
MA0GCSqGSIb3DQEBBQUAA4IBAQAn66b/WvVhpEsNXTGaZhxnUbN4+unYyQ930uxLwYrvGVxz
oEb/DoB/HJnxwly4ZVPhJ+Md8JabjkUPU7uUV/DBKjpatREOzLESa1wE++lP1QytuhEU9eIn
LDQLzpXrB2JPR9eMhh/8Qez6ikCYgIP0vNPdX2wTc1FwLvrN2YIyGqmLgGBdbUEwqY1dFn8I
9LOZR0tZT+ynNfPoQv4W7ec4BtqAbvC6bEbJ9bu2ZNEOoeX4FzpCgvtKdwQQJVDbZ9U8F3BY
5rTzZnfc73PkcSN+oDTYUQi6tVhbIqEp+DIRwx3VynbXYzJUbyKB5I2TEi2896KnWEdkdiYD
SE8yrLDmMYIDVTCCA1ECAQEwaTBeMQswCQYDVQQGEwJERTEgMB4GA1UEChMXTWF4LVBsYW5j
ay1HZXNlbGxzY2hhZnQxDzANBgNVBAMTBk1QRyBDQTEcMBoGCSqGSIb3DQEJARYNbXBnLWNh
QG1wZy5kZQIHE6OvPm/+aDAJBgUrDgMCGgUAoIIBwTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0xNDAzMDIxNDU1NTZaMCMGCSqGSIb3DQEJBDEWBBQCdIiA
ZP+72UntSucXGwCoT/G/ijBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIHMA0GCCqGSIb3DQMCAgEoMHgGCSsGAQQBgjcQBDFrMGkwXjELMAkGA1UEBhMCREUxIDAe
BgNVBAoTF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MQ8wDQYDVQQDEwZNUEcgQ0ExHDAaBgkq
hkiG9w0BCQEWDW1wZy1jYUBtcGcuZGUCBxOjrz5v/mgwegYLKoZIhvcNAQkQAgsxa6BpMF4x
CzAJBgNVBAYTAkRFMSAwHgYDVQQKExdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEPMA0GA1UE
AxMGTVBHIENBMRwwGgYJKoZIhvcNAQkBFg1tcGctY2FAbXBnLmRlAgcTo68+b/5oMA0GCSqG
SIb3DQEBAQUABIIBAK8sZr5i5RWjhP4ebMG4DTTDiVmnJPdpcaEqzjBA2amf1Wd9Anp5IOVJ
N1PrhX5vt1fMxW925P0uClY0CXdWFAKxrAqtDlGBt+LlnQkW/JcBdrLyHHuqCbmd+rLoVh3B
q3Au3l+5huP4cQfp32aG24yaYcBlQTSt7P58x1alyAwZysiMuXc+s/o98OOzRES3YlwdxmiQ
lxbTqqjjYA8FOCkbhmZvse8PBRGpiJcY8+hQ3yKNqIpRc/WLfXsCvbcx9NGtDXwJSERuxpXZ
PnUQnj7e6mHBzLGqOKMA4/9iM1M2FcSQ8cQ2GbFqZsewI1wYIjTxRxK9SeHSqJ3xBaoBo8UA
AAAAAAA=
--------------ms040507080401020204040505--
