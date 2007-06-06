From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs5 + ldap
Date: Wed, 06 Jun 2007 10:13:48 -0400
Message-ID: <x496461uq5f.fsf@segfault.boston.devel.redhat.com>
References: <370788.91736.qm@web90501.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <370788.91736.qm@web90501.mail.mud.yahoo.com> (Phy Prabab's
	message of "Sat, 12 May 2007 22:35:54 -0700 (PDT)")
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
To: Phy Prabab <phyprabab@yahoo.com>
Cc: autofs@linux.kernel.org

==> On Sat, 12 May 2007 22:35:54 -0700 (PDT), Phy Prabab <phyprabab@yahoo.com> said:

Phy> Hello!


Phy> I am having some issues with autofs5 + ldap configuration, I just
Phy> can not seem to get autofs to read the auto_master map out of
Phy> ldap.  I have tried unsuccessfully using the "samples" and my
Phy> previous configuration (autofs414 which does work with ldap).  I
Phy> tried to use the /etc/sysconfig/autofs config file paralleling
Phy> the sample but using my ldap settings as well as using
Phy> /etc/auto.master again using my ldap settings, both to no avail.
Phy> I know the ldap settings are correct, I can search the ldap
Phy> server without any issues and I am using it to authenticate
Phy> (i.e. passwords).

Phy> If anyone could lend me a suggestion, I would be most grateful.
Phy> TIA,
Phy> Phy


Phy> [root@b~]# cat /etc/auto.master
Phy> dn: automountMapName=auto_master,ou=automount,ou=defaults,ou=sanjose,ou=services,o=cadence.com
Phy> objectClass: top
Phy> objectClass: automountMap
Phy> automountMapName: auto_master
Phy> #+auto.master

Autofs does not expect to find ldif in your /etc/auto.master.  I'm
guessing this was a last resort attempt.  What did your configuration
files look like under 4.1.x?

For now, try the following.
Make sure /etc/nsswitch.conf has this line for automount:
automount: ldap

And in /etc/sysconfig/autofs, you want to have this line:
MASTER_MAP_NAME="auto_master"

Now try starting the automounter.  If this fails, please provide all
of the information requested in the section entitled, "Filing bug
reports," on my people page:
  http://people.redhat.com/jmoyer

Thanks!

Jeff
