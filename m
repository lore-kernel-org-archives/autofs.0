From: Scott Leerssen <scott@leerssen.com>
Subject: automount deletes and fails to recreate mount points
Date: Fri, 2 Nov 2007 12:30:18 -0400
Message-ID: <90849F37-9473-4251-B3EA-9E4A1FC6E675@leerssen.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary="===============8146013842001173926=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


--===============8146013842001173926==
Content-Type: multipart/alternative; boundary=Apple-Mail-13-965453579


--Apple-Mail-13-965453579
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

CentOS 5
kernel:  2.6.18-8.1.15.el5
autofs: autofs-5.0.1-0.rc2.43.0.2
SElinux: disabled

A google search and scan of the archives didn't reveal an answer, so  
I apologize in advance if this subject has been beaten to death already.

I have a stock, yum updated CentOS 5 installation on which autofs  
works fine as long as the mount points are pre-existing.  However, if  
I stop the automounter with 'service autofs stop' (or by rebooting),  
the automounter deletes my /net and /misc mount points and then fails  
to recreate them on 'service autofs start'.

One caveat to the "normal" CentOS 5 install, is that I'm running off  
of an NFS root.  Is there anything in particular about having a mount  
point inside another NFS mounted directory that would make automount  
want to remove my mount points and fail to recreate them?

Thanks,
Scott


--Apple-Mail-13-965453579
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><div><span =
class=3D"Apple-style-span" style=3D"border-collapse: separate; color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; orphans: 2; text-align: auto; text-indent: =
0px; text-transform: none; white-space: normal; widows: 2; word-spacing: =
0px; -webkit-border-horizontal-spacing: 0px; =
-webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0; "><span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: 2; text-align: auto; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: =
0px; -webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0; "><div>CentOS 5</div><div>kernel: =
=A02.6.18-8.1.15.el5</div><div>autofs: =
autofs-5.0.1-0.rc2.43.0.2</div><div>SElinux: disabled</div><div><br =
class=3D"webkit-block-placeholder"></div><div>A google search and scan =
of the archives didn't reveal an answer, so I apologize in advance if =
this subject has been beaten to death already.</div><div><br =
class=3D"webkit-block-placeholder"></div><div>I have a stock, yum =
updated CentOS 5 installation on which autofs works fine as long as the =
mount points are pre-existing. =A0However, if I stop the automounter =
with 'service autofs stop' (or by rebooting), the automounter deletes my =
/net and /misc mount points and then fails to recreate them on 'service =
autofs start'.</div><div><br =
class=3D"webkit-block-placeholder"></div><div>One caveat to the "normal" =
CentOS 5 install, is that I'm running off of an NFS root. =A0Is there =
anything in particular about having a mount point inside another NFS =
mounted directory that would make automount want to remove my mount =
points and fail to recreate them? =A0</div><div><br =
class=3D"webkit-block-placeholder"></div><div>Thanks,</div><div>Scott</div=
><div><br =
class=3D"webkit-block-placeholder"></div></span></span></div></body></html=
>=

--Apple-Mail-13-965453579--


--===============8146013842001173926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8146013842001173926==--

