From: Michael <michael@kmaclub.com>
Subject: Re: SLED 10 4.1.4-23-4 autofs question
Date: Thu, 04 Oct 2007 10:46:32 -0700
Message-ID: <470526F8.3050904@kmaclub.com>
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

Chavez, James R. wrote:
> Hello all,
> I am using Autofs version 4.1.4-23-4 on Suse Linux Enterprise Desktop
> 10. I have 2 questions.
> 1) Is there a version in the works that will support automount support
> similar to Solaris and HPUX? This version boasts no direct map support.
> I tweaked the autofs script for direct map support but it will not share
> an automounted directory with local files.
>   

Autofs5 has this capability but is not included in SLES10.  Talk to you 
support team about getting the necessary changes backported to the SuSE 
kernel and updated autofs packages.

> 2) Is there a reason I cannot automount certain NFS filesystems remotely
> from autofs but it will work from the command line?
>
>   
Usually this is because of the mount options specified via autofs versus 
defaults.  For example, in autofs are you specifying a tcp mount but 
from the command line it defaults to UDP?

Mount it by hand and look at the output /proc/mounts for that mount 
point.  Are the options the same as what are specified in your autofs 
maps and or sysconfig file?  If not, that may be the source or your problem.

Michael
