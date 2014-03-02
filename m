From: Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: "Too many levels of symbolic links"
Date: Sun, 02 Mar 2014 12:15:42 +0100
Message-ID: <531312DE.1010300@molgen.mpg.de>
References: <1391145206.2486.25.camel@perseus.fritz.box>			 <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>			 <530484B7.6030305@molgen.mpg.de>			 <1392896501.2508.16.camel@perseus.fritz.box>			 <1392898704.2508.26.camel@perseus.fritz.box>			 <530625D0.7020808@molgen.mpg.de>			 <1392946952.2495.3.camel@perseus.fritz.box>			 <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de>			 <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>			 <5310F30D.9040407@molgen.mpg.de> <53125771.4030000@molgen.mpg.de>			 <531280C5.1050906@molgen.mpg.de>		 <1393726632.9725.3.camel@perseus.fritz.box>		 <5312EBAC.2070200@molgen.mpg.de>	 <1393753284.9725.31.camel@perseus.fritz.box>	 <5313066F.6040302@molgen.mpg.de> <1393758213.9725.60.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms090005060703050408060403"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1393758213.9725.60.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Alexander Viro <aviro@redhat.com>, autofs <autofs@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms090005060703050408060403
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

I've follow the mysterious "root" up:

> (gdb) print ((struct dentry *)0xffff88007ca407d0)->d_name->name
> $10 =3D (const unsigned char *) 0xffff88007ca40808 "old-root-D0k5jB"
> (gdb) print ((struct dentry *)0xffff88007ca407d0)->d_parent->d_name->na=
me
> $11 =3D (const unsigned char *) 0xffff88007ca6c748 "private"
> (gdb) print ((struct dentry=20
> *)0xffff88007ca407d0)->d_parent->d_parent->d_name->name
> $12 =3D (const unsigned char *) 0xffff88007ca58b48=20
> "systemd-namespace-os99ZC"
> (gdb) print ((struct dentry=20
> *)0xffff88007ca407d0)->d_parent->d_parent->d_parent->d_name->name
> $13 =3D (const unsigned char *) 0xffff8800c890ce48 "tmp"
> (gdb) print ((struct dentry=20
> *)0xffff88007ca407d0)->d_parent->d_parent->d_parent->d_parent->d_name->=
name
> $14 =3D (const unsigned char *) 0xffff88012900f2c8 "/"
> root:kasslerbraten:/home/buczek/autofs/# ls -lR=20
> /tmp/systemd-namespace-os99ZC/
> /tmp/systemd-namespace-os99ZC/:
> total 0
> drwxrwxr-t 2 root system 48 Feb 28 12:33 private
> drwxrwxr-x 2 root system 48 Feb 28 12:33 root
>
> /tmp/systemd-namespace-os99ZC/private:
> total 0
>
> /tmp/systemd-namespace-os99ZC/root:
> total 0


So its systemd which is doing some strange namespace stuff in /tmp.
This probably collides in some way with the autofs model of autofs=20
having global pathnames.

Still not clear and not solved, but we're really coming closer...

Donald



Am 02.03.2014 12:03, schrieb Ian Kent:
> On Sun, 2014-03-02 at 11:22 +0100, Donald Buczek wrote:
>> Am 02.03.2014 10:41, schrieb Ian Kent:
>>> On Sun, 2014-03-02 at 09:28 +0100, Donald Buczek wrote:
>>>> Am 02.03.2014 03:17, schrieb Ian Kent:
>>>>> mnt_hash->next =3D=3D mnt_hash->prev, mount has been unlinked from =
the mount
>>>>> tree so is not "visible". As far as we are concerned this mount has=

>>>>> gone.
>>>> No, prev and next both point to the list_head in the mount_hashtable=
=2E
>>> Fair call, ->mnt_mp !=3D NULL too which implies the mount hasn't been=

>>> unlinked.
>> The problem is, that the mount is in another namespace. I've put mnt_n=
s
>> into my perl script:
>>
>>> root:kasslerbraten:/home/buczek/autofs/# ./peekmounts |grep mariux32
>>>   mountpoint 0xffff880125e44480 : count=3D   1 denty=3D0xffff88007c86=
da10
>>> (mariux32)
>>>   struct mount 0xffff8800a3a9a6c0 : mountpoint dentry
>>> 0xffff88007c86da10 (mariux32) mountpoint struct 0xffff880125e44480 NS=

>>> 0xffff8801271f9300
>>> root:kasslerbraten:/home/buczek/autofs/# ./peekmounts |grep project
>>>   mountpoint 0xffff8800c1d068a0 : count=3D   2 denty=3D0xffff8800c8b2=
e450
>>> (project)
>>>   struct mount 0xffff8800c9e5e200 : mountpoint dentry
>>> 0xffff8800c8b2e450 (project) mountpoint struct 0xffff8800c1d068a0 NS
>>> 0xffff88012d00ed00
>>>   struct mount 0xffff8800a3a9a940 : mountpoint dentry
>>> 0xffff8800c8b2e450 (project) mountpoint struct 0xffff8800c1d068a0 NS
>>> 0xffff8801271f9300
>> We have a /project without a mounted /project/mariux32 and a /project
>> with a mounted /project/mariux32 in another namespace.
> Yep, I'm struggling to follow the namespace list handling atm.
> It is something I'm going to need get to terms with because of issues
> like this.
>
>> This goes in the direction you mentioned in your other mail ("Illegal =
as
>> far as autofs is concerned because an autofs mount is strictly
>> associated with a path defined by its map") The system-wide, absolute
>> semantics of pathnames in the automount world don't fit well into the
>> process-local, relative mount semantics of the kernel.
> Yes, but a bigger issue is that the autofs semantics of multiple name
> spaces aren't defined which means all I can do for now is make
> statements like the one above.
>
> No, asking folks concerned with namespaces didn't result in useful
> feedback. Perhaps I'm asking the question in the wrong way, I don't kno=
w
> yet.
>
>> I still don't know, where these "root" or "old-root" messages come fro=
m,
>> but again the error occured after these strange messages appeared
>>
>>> 2014-02-28T12:33:08.461073+01:00 kasslerbraten kernel: [13093.129511]=

>>> pid 7670: d_set_mounted: set mounted on dentry=3Dffff88007ca58a50 roo=
t
>>> 2014-02-28T12:33:08.461074+01:00 kasslerbraten kernel: [13093.129569]=

>>> pid 7670: put_mountpoint: mp=3Dffff8801271f9338
>>> 2014-02-28T12:33:08.461075+01:00 kasslerbraten kernel: [13093.129574]=

>>> pid 7670: d_set_mounted: dentry=3Dffff8800c890ce10 tmp
>>> 2014-02-28T12:33:08.461076+01:00 kasslerbraten kernel: [13093.129575]=

>>> pid 7670: d_set_mounted: set mounted on dentry=3Dffff8800c890ce10 tmp=

>>> 2014-02-28T12:33:08.461077+01:00 kasslerbraten kernel: [13093.129578]=

>>> pid 7670: put_mountpoint: mp=3Dffff8801271f9338
>>> 2014-02-28T12:33:08.461078+01:00 kasslerbraten kernel: [13093.129599]=

>>> pid 7670: d_set_mounted: dentry=3Dffff88007ca407d0 old-root-D0k5jB
>>> 2014-02-28T12:33:08.461079+01:00 kasslerbraten kernel: [13093.129601]=

>>> pid 7670: d_set_mounted: set mounted on dentry=3Dffff88007ca407d0
>>> old-root-D0k5jB
>>> 2014-02-28T12:33:08.461080+01:00 kasslerbraten kernel: [13093.129602]=

>>> pid 7670: put_mountpoint: mp=3Dffff8800c9e5e750
>>> 2014-02-28T12:33:08.461081+01:00 kasslerbraten kernel: [13093.129603]=

>>> pid 7670: put_mountpoint: cleared mounted on dentry=3Dffff88007ca58a5=
0 root
>>> 2014-02-28T12:33:08.461082+01:00 kasslerbraten kernel: [13093.129604]=

>>> pid 7670: put_mountpoint: mp=3Dffff8800c9e5e610
>>> 2014-02-28T12:33:08.461082+01:00 kasslerbraten kernel: [13093.129662]=

>>> pid 7670: put_mountpoint: mp=3D0000014800450045
>>> 2014-02-28T12:33:08.461083+01:00 kasslerbraten kernel: [13093.129663]=

>>> pid 7670: put_mountpoint: mp=3D0000000000000006
>> (as explained in another mail , the addresses of "mp=3D" are wrong, so=

>> don't worry about these)
>>
>> This looks like chroot or somesuch. But I have no idea. I don't find
>> \"root or \"old- in any sources. There is not "root" in any map.
> Can't see anything myself but I've lost track of what kernel version
> we're using here, what is it again?
>
>> Hmmm. Isn't the daemon doing lazy umounts? Could it be this?
> You would need to have a fairly old version of autofs for it to be doin=
g
> lazy umounts and you'd probably be seeing different problems as a
> result. In particular, processes unable to successfully call getcwd() o=
r
> scripts unable to get pwd from /proc/<pid>/cwd.
>
>> I've compiled the daemon with --enable-ignore-busy
> Umm .. now your making me think.
>
> IIRC I added that so the daemon would not refuse to exit when it
> encountered mounts that were in use. The idea being to reconstruct the
> user space data structures at startup essentially re-connecting to the
> mounts left mounted. Sure, that has it's own set of difficulties but
> they are much less offensive than the problems seen by using lazy
> umount.
>
> In short it isn't related to lazy umounts.
>
> Although I think there's a case were they could be used if you don't us=
e
> the miscellaneous device for ioctl control. But you need to explicitly
> remove the device file (or make it inaccessible) to make that happen.
> There isn't anything like that in any systemd units I'm aware of so
> autofs will use the device file by default.
>
>> Anything forcing the daemon to restart?
>> systemd doing stupid things to the daemon or the filesystem?
>>
>>> [Service]
>>> Type=3Dforking
>>> ExecStartPre=3D/sbin/make-automaps
>>> ExecStart=3D/usr/sbin/automount -v
>>> PIDFile=3D/run/autofs-running
>>> ExecReload=3D/bin/kill -HUP $MAINPID
> This isn't the systemd unit that's included in the package tar.
> I have no idea what /sbin/make-automaps is or does.
>
> Other than the unknown make-automaps it looks like it should be OK.
>
>>     Donald
>>
>


--=20
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433



--------------ms090005060703050408060403
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
AQcBMBwGCSqGSIb3DQEJBTEPFw0xNDAzMDIxMTE1NDJaMCMGCSqGSIb3DQEJBDEWBBQSXQNy
1xokPesr+VCPhrCUqCorTDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIHMA0GCCqGSIb3DQMCAgEoMHgGCSsGAQQBgjcQBDFrMGkwXjELMAkGA1UEBhMCREUxIDAe
BgNVBAoTF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MQ8wDQYDVQQDEwZNUEcgQ0ExHDAaBgkq
hkiG9w0BCQEWDW1wZy1jYUBtcGcuZGUCBxOjrz5v/mgwegYLKoZIhvcNAQkQAgsxa6BpMF4x
CzAJBgNVBAYTAkRFMSAwHgYDVQQKExdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEPMA0GA1UE
AxMGTVBHIENBMRwwGgYJKoZIhvcNAQkBFg1tcGctY2FAbXBnLmRlAgcTo68+b/5oMA0GCSqG
SIb3DQEBAQUABIIBACCEJeIkfrnEQDpRUdTqOx0SBoPiwLkyIUW5oqtDOQX0x6qxJ/JOBFbu
dsPMcTWAWsWBP/Af7+HH/LcEooIpq4kcKlepzkoq+3LQ9WUBesnbvvvJ3C+Eji0nvy0iBuQq
7viJMIjkS+JOPcLsq6wOR6UIWE2nFQrQM62fZrztENM801td35Tiv+49cMDKah5ZgdQsa69M
Or16qcCpn3gs0XmJT0z83aEu2RgFx5rcteYZFLUtdPuLU5CfqJIRj8aiLv3Ekaz0zg0ISYVi
5Qu5rYZzTjEKfTbEW0GFEY6xbumVoyEd05x7uGv8aq6kk2Opz/M92YsuhY93emt52AAUrbIA
AAAAAAA=
--------------ms090005060703050408060403--
