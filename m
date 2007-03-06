From: Ian Kent <raven@themaw.net>
Subject: Re: automount dies almost immediately after upgrade
	to	autofs 5.0.1
Date: Tue, 06 Mar 2007 17:22:45 +0900
Message-ID: <1173169365.3399.1.camel@raven.themaw.net>
References: <1173159373.3989.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1173159373.3989.18.camel@localhost.localdomain>
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
To: Dan Krejsa <dan.krejsa@alamedanet.net>
Cc: autofs@linux.kernel.org

On Mon, 2007-03-05 at 21:36 -0800, Dan Krejsa wrote:
> Hi,
> 
> Yesterday I updated autofs, the kernel, selinux-policy, and 
> a few other things on my Fedora Core 6 laptop.  Today I brought
> my laptop in to work, and autofs failed for /net mounts.
> 
> Here's the relevant section of yum.log:
> 
> Mar 04 13:12:39 Installed: kernel-xen.i686 2.6.19-1.2911.6.4.fc6
> Mar 04 13:12:51 Installed: kernel.i686 2.6.19-1.2911.6.4.fc6
> Mar 04 13:12:51 Installed: ieee80211-kmdl-2.6.19-1.2911.6.4.fc6.i686 1.2.16-17.fc6.at
> Mar 04 13:12:52 Installed: ieee80211-kmdl-2.6.19-1.2911.6.4.fc6xen.i686 1.2.16-17.fc6.at
> Mar 04 13:12:58 Updated: vim-common.i386 2:7.0.201-1.fc6
> Mar 04 13:13:01 Updated: selinux-policy.noarch 2.4.6-41.fc6
> Mar 04 13:13:03 Updated: kernel-headers.i386 2.6.19-1.2911.6.4.fc6
> Mar 04 13:13:04 Updated: readahead.i386 1:1.3-7.fc6
> Mar 04 13:13:04 Installed: ipw3945-kmdl-2.6.19-1.2911.6.4.fc6xen.i686 1.2.0-18.2.fc6.at
> Mar 04 13:13:06 Updated: autofs.i386 1:5.0.1-0.rc3.23
> Mar 04 13:13:07 Updated: vim-enhanced.i386 2:7.0.201-1.fc6
> Mar 04 13:13:14 Updated: selinux-policy-targeted.noarch 2.4.6-41.fc6
> Mar 04 13:13:15 Installed: nvidia-graphics9629-kmdl-2.6.19-1.2911.6.4.fc6.i686 1:1.0_9629-81.fc6.at
> Mar 04 13:13:15 Updated: vim-minimal.i386 2:7.0.201-1.fc6
> Mar 04 13:13:16 Installed: nvidia-graphics9629-kmdl-2.6.19-1.2911.6.4.fc6xen.i686 1:1.0_9629-81.fc6.at
> Mar 04 13:13:17 Installed: ipw3945-kmdl-2.6.19-1.2911.6.4.fc6.i686 1.2.0-18.2.fc6.at
> 
> I tried restarting autofs using '/etc/init.d/autofs start'
> and it would claim success "[OK]", but in a few seconds (probably
> less than a minute) the automount process would
> disappear and '/etc/init.d/autofs status' would report
> autofs stopped. DNS & general network connectivity were working.

Is there anything at all in the logs?
You can get a debug log by following the instructions at
http://people.redhat.com/jmoyer

Ian
