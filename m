From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Sat, 5 Jun 2004 23:57:17 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16578.38429.674272.829876@segfault.boston.redhat.com>
References: <16575.35426.918728.134817@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
	<16576.51269.311121.121046@segfault.boston.redhat.com>
	<16576.60526.394177.533027@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406051327020.12824@donald.themaw.net>
	<16578.35042.873671.838640@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406061111350.2275@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406061111350.2275@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding Re: [autofs] [RFC] rpc_ping and looong timeouts; raven@themaw.net adds:

raven> On Sat, 5 Jun 2004, Jeff Moyer wrote:
>> Yes, that looks correct to me.  I tested it with the same test case I
>> was using before, and all is well.  One thing:
>> 
mount_nfs.c> In function `get_best_mount': 232: warning: implicit
mount_nfs.c> declaration of function `icmp_ping_host'
>> You forgot to #include "ping.h"!  Maybe between the two of us we'll get
>> this right.  ;)

raven> Ha! Missed that.

raven> I'll fix it in mine and commit it.

For those interested, packages with this patch included are available on my
people site:
       http://people.redhat.com/~jmoyer/

Included is the changelog for 4.1.3 thus far.  Share and enjoy!

-Jeff


* Sat Jun  5 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-4 
- Perform an icmp ping request before rpc_pings, since the rpc clnt_create 
  function has a builtin default timeout of 60 seconds.  This could result 
  in a long delay when a server in a replicated mount setup is down. 
- For non-replicated server entries, ping a host before attempting to mount. 
  (Ian Kent) 
- Change to %configure. 
- Put version-release into .version to allow for automount --version to 
  print exact info. 
- Nuke my get-best-mount patch which always uses the long timeout.  This 
  should no longer be needed. 
- Put name into changelog entries to make them consistent.  Add e:n-v-r 
  into Florian's entry. 
- Stop autofs before uninstalling 
 
* Sat Jun 05 2004 Florian La Roche <Florian.LaRoche@redhat.de> - 1:4.1.3-3 
- add a preun script to remove autofs 
 
* Tue Jun  1 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-2 
- Incorporate patch from Ian which fixes an infinite loop seen by those 
  running older versions of the kernel patches (triggered by non-strict mounts 
  being the default). 
 
* Tue Jun  1 2004 Jeff Moyer <jmoyer@redhat.com> - 1:4.1.3-1 
- Update to upstream 4.1.3. 
