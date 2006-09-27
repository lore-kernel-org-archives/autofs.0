From: Dana Wellen <dana.wellen@onsemi.com>
Subject: Re: Simple direct mout problem
Date: Wed, 27 Sep 2006 14:05:40 -0400
Message-ID: <451ABD74.7060908@onsemi.com>
References: <45196B1C.5040303@onsemi.com>
	<1159324405.2897.27.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6864073007199640125=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1159324405.2897.27.camel@raven.themaw.net>
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

--===============6864073007199640125==
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Ian,<br>
&nbsp; Finally figured it out, simply put:<br>
<br>
auto.master<br>
<br>
/-&nbsp;&nbsp; &nbsp;&nbsp; yp:auto.linux<br>
<br>
auto.linux<br>
<br>
/some_mount_directory/example&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; server:/nfs_export<br>
<br>
works.&nbsp; However if the yp map is changed to<br>
<br>
/example&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; server:/nsf_export <br>
<br>
it fails.&nbsp; The error in the messages file aren't very helpful in
figuring this simple error out.&nbsp; <br>
<br>
Will the next version (5) work more like the Sun automounter? I know in
our case we are moving off of standard <br>
Unix to Linux due to support being dropped for our main platform
(HP-UX) for our CAD software vendors.<br>
<br>
What I am seeing with indirect mounts and ghosting is that the only
directories visible in the mount directory<br>
are directories that are mounted or been mounted but won't show the
directories never mounted, examples:<br>
<br>
Before any mounts:<br>
<br>
ls -la /proj<br>
total 8<br>
drwxr-xr-x&nbsp;&nbsp; 2 root root&nbsp;&nbsp;&nbsp; 0 Sep 27 14:02 .<br>
drwxr-xr-x&nbsp; 29 root root 4096 Sep 27 14:01 ..<br>
<br>
ls /proj/some_directory<br>
file1 file2 directory1 directory2 etc..<br>
<br>
ls -la /proj<br>
total 12<br>
drwxr-xr-x&nbsp;&nbsp; 3 root&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp; 0 Sep 27 14:03 .<br>
drwxr-xr-x&nbsp; 29 root&nbsp;&nbsp; root 4096 Sep 27 14:01 ..<br>
drwxrwxr-x&nbsp;&nbsp; 9 root root&nbsp; 4096 Nov&nbsp; 3&nbsp; 2005 some_directory<br>
<br>
Well after the 60 second timeout<br>
ls -la /proj<br>
total 12<br>
drwxr-xr-x&nbsp;&nbsp; 3 root&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp; 0 Sep 27 14:03 .<br>
drwxr-xr-x&nbsp; 29 root&nbsp;&nbsp; root 4096 Sep 27 14:01 ..<br>
drwxrwxr-x&nbsp;&nbsp; 9 root root&nbsp; 4096 Nov&nbsp; 3&nbsp; 2005 some_directory<br>
<br>
This directory holds over 100 subdirectories that the user can't see
and can only be accessed if<br>
they know the name of the subdirectory.<br>
<br>
Thanks,<br>
Dana<br>
<br>
<br>
Ian Kent wrote:
<blockquote cite="mid1159324405.2897.27.camel@raven.themaw.net"
 type="cite">
  <pre wrap="">On Tue, 2006-09-26 at 14:02 -0400, Dana Wellen wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hello,

   Trying to setup a simple direct map using nis and the autofs automounter:

automount -V
Linux automount version 4.1.3-67
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This version is way to old.
Update it.

  </pre>
  <blockquote type="cite">
    <pre wrap="">/etc/auto.master

/-      yp:auto.linux


ypcat -k auto.linux

/proj server2:/vol/proj/xx_proj
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Nop.
There are an number of limitations with direct mounts in version 4.
Single level direct mounts is one.

  </pre>
  <blockquote type="cite">
    <pre wrap="">This is documented in the readme file in 
/usr/share/doc/aufofs-4.1.3/README.direct

When the autofs is started or restarted in the /var/log/messages I get :

automount[25461]: cache_ghost: entry in yp:auto.linux not valid map 
format, key /proj

If I use indirect mounts it works however direct mounts would be a lot 
easier for my users in that
they will be able to see the directories in the mounted directory.  The 
ghost function doesn't work
well because it will only show the mounted directories or the 
directories that have been mounted
since the last restart of the autofs.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
That's not correct.

  </pre>
  <blockquote type="cite">
    <pre wrap="">  If I copy the file to the /etc directory it still has a similar error.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Huh ????

  </pre>
  <blockquote type="cite">
    <pre wrap="">
aufofs-4.1.3/README.direct
-- For example if we were using NIS we might have something like
the map entries below.

In the master map:

/-      autofs.global

and in autofs.global:

/nfs/apps/mozilla       bogus:/usr/local/moxilla
/nfs/data/budgets       tiger:/usr/local/budgets
/tst/sbin               bogus:/usr/sbin

and so on.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Note that the RedHat package has a config entry that disables direct
mounts by default because of the limitations.

Change it if you wish to try using them (in /etc/sysconfig/autofs).

Ian



  </pre>
</blockquote>
<br>
<div class="moz-signature">-- <br>
<br>
</div>
</body>
</html>


--===============6864073007199640125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6864073007199640125==--
