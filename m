From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: csh/cd not getting the right cwd at the mount point
Date: Mon, 12 Jul 2004 08:35:31 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16626.34195.267988.648284@segfault.boston.redhat.com>
References: <BA0E4392AD99D040885C414D992C24BE08264B56@us-bv-m11.bv.tek.com>
	<Pine.LNX.4.58.0407101248510.1378@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0407101248510.1378@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

=3D=3D> Regarding Re: [autofs] csh/cd not getting the right cwd at the mo=
unt point; raven@themaw.net adds:

raven> On Fri, 9 Jul 2004 peter.a.harris@exgate.tek.com wrote: I'm having
raven> difficulty understanding the problem you describe.

>> We have a problem.  Here are the conditions:
>>=20
>> 1. Shell is (t)csh (does not happen under (ba)sh) 2. cd to an autofs
>> fa=E7ade (e.g. /tools in our case) 3. cd relatively to the subdirector=
y
>> that is the mount point.
NOTE> The mount must not yet be made. (e.g. perl5.8.3)
>> 4. cd relatively to a subdirectory in the mounted files system (e.g. b=
in
>> or lib)

[snip]

raven> I recommend you try autofs4 release 20040508. Unfortuneately this
raven> release requires a kernel rebuild as there is a small mandatory
raven> change outside of the autofs4 module needed for correct
raven> operation. This release is the one that should be used as it
raven> addresses all known problems and works best with the latest autofs
raven> release.

raven> You should be using autofs-4.1.3. There is an additional patch tha=
t
raven> I have recommened a couple of times now, without adverse feedback,
raven> that my fix your problem. I've uploaded it to kernel.org and it ca=
n
raven> be found at:

[snip]

NOTE: I was not able to reproduce the problem in my environment, which
included our next update kernel that is fully patched with Ian's latest
kernel patch kit.  I'm using autofs-4.1.3-10, which will appear on my
people page soon.

raven> As a RHEL user visiting Jeff Moyers autofs page is a must as there
raven> are patches included their that have not yet been included in an
raven> autofs release


raven> http://people.redhat.com/~jmoyer

raven> Jeff, would it be possible to include the two patches mentioned
raven> above in your rpms please.

Sure thing.  I'm doing builds for this now.  I'm currently tracking the
following patches that I _think_ are queued for the next release.  Please
correct me if I'm wrong, or if you want me to resend anything.


Patch12: autofs-4.1.2-option-parsing.patch
- Make regular expressiosn for options parsing a bit more strict.  Fixes
  bugs I have filed on the package for false matches of either mount poin=
ts
  or other fs options.

Patch14: autofs-4.1.3-underlinei18n.patch
- This is a patch which makes translation prettier (AFAIUI).  Note, I
  didn't write this, and didn't send it to you.  I've attached it to this
  mail.

Patch15: autofs-4.1.3-rpc-ping.patch
- Ian, you know very well what this is.  ;)

And, the two you just had me put in:

Patch16: autofs-4.1.3-bad_chdir.patch
Patch17: autofs-4.1.3-mtab_lock.patch

-Jeff

--- autofs-4.1.3/samples/rc.autofs.in.i18n	2004-06-21 13:22:12.000000000 =
-0400
+++ autofs-4.1.3/samples/rc.autofs.in	2004-06-21 13:31:29.000000000 -0400
@@ -244,12 +244,10 @@
 #
 function status()
 {
-	echo $"Configured Mount Points:"
-	echo  "------------------------"
+	echo -e $"Configured Mount Points:\n------------------------"
 	getmounts
 	echo ""
-	echo $"Active Mount Points:"
-	echo  "--------------------"
+	echo -e $"Active Mount Points:\n--------------------"
 	ps axwww|grep "[0-9]:[0-9][0-9] $DAEMON " | (
 		while read pid tt stat time command; do echo $command; done
 	)
@@ -356,7 +354,7 @@
 	    fi
 	    [ $RETVAL =3D 0 ] && touch /var/lock/subsys/autofs
 	else
-	    echo -n "" $"No Mountpoints Defined"
+	    echo -n $"No Mountpoints Defined"
 	    success "$prog startup"
 	fi
 	rm -f $TMP
