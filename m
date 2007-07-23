From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: reload when using LDAP
Date: Mon, 23 Jul 2007 10:11:18 -0400
Message-ID: <x49tzrvqkft.fsf@segfault.boston.devel.redhat.com>
References: <812495870707161521g638be314ye81a8df6a9806582@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <812495870707161521g638be314ye81a8df6a9806582@mail.gmail.com>
	(William Prochazka's message of "Mon\,
	16 Jul 2007 18\:21\:59 -0400")
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
To: William Prochazka <billprozac@gmail.com>
Cc: autofs@linux.kernel.org

==> On Mon, 16 Jul 2007 18:21:59 -0400, "William Prochazka" <billprozac@gmail.com> said:

William> We use LDAP to store all of our map data which seems to be working very well
William> (all FC6 so autofs v5.0.1 RC3).  First off, we found out the hardway that
William> when autofs is restarted (like as part of a cron job) and a local autofs
William> filesystem is in use (direct map) ... kernel panic.  The restarting was

Did you report this bug?  If not, please do:
  http://bugzilla.redhat.com/

William> originally so we could push new maps and clients we get the maps nightly.
William> After the kernel panic fiasco, I nticed the reload option (should be much
William> safer since in our enviornment it would almost always only be adding new
William> maps).  Sounds good, but it does not work.  Reload fails as it cannot start

Reload, at least in the past, was used to detect added or removed
mount points listed in /etc/auto.master.

William> TLS, so it loads a null map and kills all unused daemons.  I have no idea
William> why it cannot start TLS since the service has no issues when starting and I
William> can see it querying ldap for the auto.master and the mount ou.  So this
William> leads to a few questions:

William> 1. Does autofs only use the /etc/openldap/ldap.conf file, or does the reload
William> function use the /etc/ldap.conf file I think that is a hold over for legacy
William> applications)

Autofs uses /etc/openldap/ldap.conf

William> 2. Is there a good way to debug what exactly is failing with the reload? (I
William> have logging set to debug but that give little useful info.

Do you have daemon.* being logged somewhere?  See
http://people.redhat.com/jmoyer for a guide to gathering debug
information.

William> 3.  What is the best way to have clients poll for updates to the autofs
William> maps?

Autofs does this on its own.  It should detect map updates when
performing mounts, so you can get rid of your cron jobs.

-Jeff
