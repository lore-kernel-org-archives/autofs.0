From: Ian Kent <raven@themaw.net>
Subject: Re: SLED 10 4.1.4-23-4 autofs question
Date: Fri, 05 Oct 2007 09:57:52 +0800
Message-ID: <1191549472.3159.5.camel@raven.themaw.net>
References: <E8B9048B7B76C34591C575B63EB76D5D843F4D@phx1amfpew01.am.sanm.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E8B9048B7B76C34591C575B63EB76D5D843F4D@phx1amfpew01.am.sanm.corp>
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
To: "Chavez, James R." <james.chavez@sanmina-sci.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-10-04 at 10:23 -0700, Chavez, James R. wrote:
> Hello all,
> I am using Autofs version 4.1.4-23-4 on Suse Linux Enterprise Desktop
> 10. I have 2 questions.
> 1) Is there a version in the works that will support automount support
> similar to Solaris and HPUX? This version boasts no direct map support.
> I tweaked the autofs script for direct map support but it will not share
> an automounted directory with local files.

Just a quick look and I see RHEL 5, RHEL 4U6 and Fedora since 6,
OpenSUSE (I don't know since when but it's in 10.3) all have autofs
version 5.

Bug Novel.

> 2) Is there a reason I cannot automount certain NFS filesystems remotely
> from autofs but it will work from the command line?

No details, so no idea.

autofs uses mount(8) so maybe the options are getting mangled or support
for the "-s" mount option has been dropped from you mount. That has
happened from time to time and usually causes strange problems.

Ian
