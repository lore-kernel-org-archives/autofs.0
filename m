From: Bill Ryder <bill.ryder.nz@gmail.com>
Subject: I have some patches for the autofs-4.x daemon - what to do
	with them?
Date: Wed, 1 Dec 2010 11:07:10 +1300
Message-ID: <AANLkTinCncue4d-g_c0fSF1smE3i8cT-GT+w-eDygGPF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1659528466550916450=="
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:mime-version:received:from:date
	:message-id:subject:to:content-type;
	bh=rHmZnUKXkIIShxyT7dI8c+ufp3K2CeXfPVROsI3A2+M=;
	b=BOORokc2pemBxmXAjFyYxvqNC4+XQy8f7Xu7PYg3y5bty0UXmi5WwN3qeVTqoVOfga
	zKuB21K517APhut9aHIc5U4/lpoNopI2guso1go5KgCbVhm6q3u11vKKy3X/9nFicf37
	sH1Rmk9nr2u4RXbugcXxt4VFnXgEd1WQMZHb0=
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

--===============1659528466550916450==
Content-Type: multipart/alternative; boundary=000325575fde35568d04964c6a51

--000325575fde35568d04964c6a51
Content-Type: text/plain; charset=ISO-8859-1

Where should I submit those?

Or should I just put it on github or something for anyone who wants them
since the autofs-4.x daemon series has been deprecated in favour of the
autofs-5.x series.

We have about 2 or 3,000 clients where I work and autofs is crucial to our
operation.

 We use ldap and use a simple automount structure. We have about 450
mountpoints and 19 maps.

I don't like autofs-5 because I cant' fix automounts individually. It's very
convenient to be able to restart individual mounts. Also when a daemon core
dumps they don't take out every single map. Also I prefer automount to run
the mount command itself - rather than building it into the daemon.

The main work I've done is to build in retrying mounts depending on the
errors returned by mount (with our client count we overload our fileservers
often which causes retryable errors, and sometimes a client will try to
mount 100 or so mount points in a very short amount of time which causes
some tcp client port exhaustion - which is also retryable).

I've fixed a nasty bug that will crash a daemon if an error occurs while
mounting, and another request comes in for a nonexistent mount point.

I  have a flag which helps our samba servers - particular when accessed by
macs. There's an option that tells the daemon to return 'not found' for any
mount which starts with a . or contains a '*' without looking up ldap. This
makes it very fast to handle macs looking to .DS_store and many other dot
files/directories when someone browses the top of a map with ghosting on.
The '*' was quite amusing (for me anyway) because every so often you'd see a
'*' directory in an automount directory. Turns out someone had escaped the
'*' and ldap returns the first match.

And I reinstated the ldap-cleanup patch which is a much cleaner way to
handle the multiple schemas - particularly important because we recently
moved to rfc2307bis because I was sick of people being able to mount

/vol/AmounTPoINT and /vol/amountpoint and so on.

Anyway. What do do with this stuff?

Bill Ryder

--000325575fde35568d04964c6a51
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Where should I submit those?<div><div><div><div><br></div><div>Or should I =
just put it on github or something for anyone who wants them since the auto=
fs-4.x daemon series has been deprecated in favour of the autofs-5.x series=
.</div>

<div><br></div><div>We have about 2 or 3,000 clients where I work and autof=
s is crucial to our operation.</div><div><br></div><div>=A0We use ldap and =
use a simple automount structure. We have about 450 mountpoints and 19 maps=
.=A0</div>

<div><br></div><div>I don&#39;t like autofs-5 because I cant&#39; fix autom=
ounts individually. It&#39;s very convenient to be able to restart individu=
al mounts. Also when a daemon core dumps they don&#39;t take out every sing=
le map. Also I prefer automount to run the mount command itself - rather th=
an building it into the daemon.</div>

<div><br></div><div>The main work I&#39;ve done is to build in retrying mou=
nts depending on the errors returned by mount (with our client count we ove=
rload our fileservers often which causes retryable errors, and sometimes a =
client will try to mount 100 or so mount points in a very short amount of t=
ime which causes some tcp client port exhaustion - which is also retryable)=
.</div>

<div><br></div><div>I&#39;ve fixed a nasty bug that will crash a daemon if =
an error occurs while mounting, and another request comes in for a nonexist=
ent mount point.</div><div><br></div><div>I =A0have a flag which helps our =
samba servers - particular when accessed by macs. There&#39;s an option tha=
t tells the daemon to return &#39;not found&#39; for any mount which starts=
 with a . or contains a &#39;*&#39; without looking up ldap. This makes it =
very fast to handle macs looking to .DS_store and many other dot files/dire=
ctories when someone browses the top of a map with ghosting on. The &#39;*&=
#39; was quite amusing (for me anyway) because every so often you&#39;d see=
 a &#39;*&#39; directory in an automount directory. Turns out someone had e=
scaped the &#39;*&#39; and ldap returns the first match.=A0</div>

<div><br></div><div>And I reinstated the ldap-cleanup patch which is a much=
 cleaner way to handle the multiple schemas - particularly important becaus=
e we recently moved to rfc2307bis because I was sick of people being able t=
o mount</div>

<div><br></div><div>/vol/AmounTPoINT and /vol/amountpoint and so on.=A0</di=
v><div><br></div><div>Anyway. What do do with this stuff?</div><div><br></d=
iv><div>Bill Ryder</div><div><br></div><div><br></div></div></div></div>


--000325575fde35568d04964c6a51--


--===============1659528466550916450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1659528466550916450==--

