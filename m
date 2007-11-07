From: Scott Leerssen <scott@leerssen.com>
Subject: Re: automount deletes and fails to recreate mount points
Date: Wed, 7 Nov 2007 08:39:22 -0500
Message-ID: <3CE53FD7-F085-4313-AB14-8A733742BF4B@leerssen.com>
References: <0E22C564-0BD1-4930-889E-CBB4EBF05C52@leerssen.com>
	<1194405020.3113.8.camel@raven.themaw.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary="===============1248190760369703736=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1194405020.3113.8.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


--===============1248190760369703736==
Content-Type: multipart/alternative; boundary=Apple-Mail-15--760285678


--Apple-Mail-15--760285678
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Nov 6, 2007, at 10:10 PM, Ian Kent wrote:

> On Mon, 2007-11-05 at 12:43 -0500, Scott Leerssen wrote:
>> Hi,
>>
>>
>> A google search and scan of the archives didn't reveal an answer,  
>> so I
>> apologize in advance if this subject has been beaten to death
>> already.  Here are a few version numbers for reference:
>>
>>
>> CentOS 5
>> kernel:  2.6.18-8.1.15.el5
>> autofs: autofs-5.0.1-0.rc2.43.0.2
>> SElinux: disabled
>>
>>
>> I have a stock, yum updated CentOS 5 installation on which autofs
>> works fine as long as the mount points are pre-existing.  However, if
>> I stop the automounter with 'service autofs stop' (or by rebooting),
>> the automounter deletes my /net and /misc mount points and then fails
>> to recreate them on 'service autofs start'.
>>
>>
>> One caveat to the "normal" CentOS 5 install, is that I'm running off
>> of an NFS root.  Is there anything in particular about having a mount
>> point inside another NFS mounted directory that would make automount
>> want to remove my mount points and fail to recreate them?
>
> Yes.
> Does pre-creating them within the NFS mounted root work OK?
>
> Ian
>

Yes, if the mounts are pre-existing, they mount up fine.  When the  
system reboots, however, they go away.  An obvious workaround is to  
write a script that scans /etc/auto.master, parse out the mount  
points and create them before autofs starts, but I was hoping there  
was a less "cave man" solution.

Scott

PS: no offense to cave men.  That seems to be a sensitive subject  
these days.
--Apple-Mail-15--760285678
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">
<br><div><div>On Nov 6, 2007, at 10:10 PM, Ian Kent wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">On Mon, 2007-11-05 at 12:43 -0500, Scott Leerssen =
wrote:</div> <blockquote type=3D"cite"><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Hi,<span =
class=3D"Apple-converted-space">=A0</span></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">A google search and scan of the =
archives didn't reveal an answer, so I</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">apologize in advance if this subject has been beaten to =
death</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">already.<span =
class=3D"Apple-converted-space">=A0 </span>Here are a few version =
numbers for reference:</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; min-height: 14px; =
"><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">CentOS 5</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">kernel:<span =
class=3D"Apple-converted-space">=A0 </span>2.6.18-8.1.15.el5</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">autofs: autofs-5.0.1-0.rc2.43.0.2</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">SElinux: disabled</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">I have a stock, yum updated =
CentOS 5 installation on which autofs</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">works =
fine as long as the mount points are pre-existing.<span =
class=3D"Apple-converted-space">=A0 </span>However, if</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">I stop the automounter with 'service autofs stop' =
(or by rebooting),</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">the automounter deletes my =
/net and /misc mount points and then fails</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">to =
recreate them on 'service autofs start'.</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">One caveat to the "normal" =
CentOS 5 install, is that I'm running off</div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">of an =
NFS root.<span class=3D"Apple-converted-space">=A0 </span>Is there =
anything in particular about having a mount</div><div style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">point =
inside another NFS mounted directory that would make automount</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">want to remove my mount points and fail to recreate =
them? <span class=3D"Apple-converted-space">=A0</span></div> =
</blockquote><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Yes.</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Does =
pre-creating them within the NFS mounted root work OK?</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><br></div><div style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">Ian</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div> =
</blockquote></div><br><div> <span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: 2; text-align: auto; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: =
0px; -webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0; "><span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: 2; text-align: auto; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: =
0px; -webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0; "><div>Yes, if the mounts are =
pre-existing, they mount up fine. =A0When the system reboots, however, =
they go away. =A0An obvious workaround is to write a script that scans =
/etc/auto.master, parse out the mount points and create them before =
autofs starts, but I was hoping there was a less "cave man" =
solution.</div><div><br =
class=3D"webkit-block-placeholder"></div><div>Scott</div><div><br =
class=3D"webkit-block-placeholder"></div><div>PS: no offense to cave =
men. =A0That seems to be a sensitive subject these =
days.</div></span></span></div></body></html>=

--Apple-Mail-15--760285678--


--===============1248190760369703736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1248190760369703736==--

