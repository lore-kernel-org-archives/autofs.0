From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Limit on return string from program map
Date: Fri, 17 Dec 2004 12:28:16 -0500
Message-ID: <16835.5936.56572.109035@segfault.boston.redhat.com>
References: <21502.1103178424@kao2.melbourne.sgi.com>
	<Pine.LNX.4.58.0412171422280.22350@wombat.indigo.net.au>
	<16834.63746.614567.523947@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16834.63746.614567.523947@segfault.boston.redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>, autofs@linux.kernel.org, Keith Owens <kaos@ocs.com.au>

==> Regarding Re: [autofs] Limit on return string from program map; Jeff Moyer <jmoyer@redhat.com> adds:

==> Regarding Re: [autofs] Limit on return string from program map; Ian Kent <raven@themaw.net> adds:
raven> On Thu, 16 Dec 2004, Keith Owens wrote:
>>> Kernel 2.6.9, autofs v4 as a module, autofs-4.1.3-28 (FC3).  I added
>>> "/net /etc/auto.net" to /etc/auto.master and it works fine, up to a
>>> point.  ps shows
>>> 
>>> /usr/sbin/automount --timeout=60 /net program /etc/auto.net
>>> 
>>> If the target server has a lot of mounted filesystems then automount
>>> will only mount the first few entries on the list.  Then it tries to
>>> run mount with invalid input.  It looks like there is a hard coded
>>> limit on the string that automount expects from a program map.  My
>>> virtual CD server has lots of CD images mounted over loopback, each
>>> with its own export entry, so the return string from auto.net is quite
>>> long.

raven> The buffer size for map entries is 4096.

jmoyer> I think I posted a patch here that would extend that?  I can't seem
jmoyer> to find it in the archives, so I'll repost.  This is the version of
jmoyer> the patch that is in our tree, so no guarantees about it applying
jmoyer> to Ian's tree.  *sigh* (patch originally done by from Neil Horman)

jmoyer> Ian, when is 4.1.4 coming out.  ;-)

Bah, and it was just pointed out to me that this patch adds a bug.  I'll
repost the patch when the bug is fixed.  (see red hat bz #138994).

No ETA just yet.

-Jeff
