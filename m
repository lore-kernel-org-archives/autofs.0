From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] fixes problems w/ duplicate maps in auto.master
Date: Fri, 22 Oct 2004 13:34:56 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410221333000.7438@wombat.indigo.net.au>
References: <1098395176.3014.42.camel@gold.msp.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1098395176.3014.42.camel@gold.msp.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Feist <cfeist@redhat.com>
Cc: autofs@linux.kernel.org

On Thu, 21 Oct 2004, Chris Feist wrote:

> Ian,
> 
> This patch should replace the previous init-duplicate-map.patch I
> submitted last week.
> 
> The following patch contains fixes to prevent duplicate directories from
> being mapped on top of each other.
> 
> For example, if my auto.master looks like this.
> /misc auto.misc
> /misc/misc2 auto.misc2
> 
> The automounter will attempt to mount /misc/misc2 on top of the already
> mounted /misc and fail.  There were also problems where the automounter
> thought that '/misc' was different than /misc/ which is also fixed.
> 
> Lastly, knownmaps is only added to if the map is not a duplicate.  It
> wasn't being used anywhere else in the code and I don't think there is
> any reason to check new maps against maps that we know aren't valid.
>

Cool. I've known about this for ages but haven't tracked it down. I'll 
have a closer look at the patch and add it to the list as well.
 
> Let me know if you don't agree or you thing something needs to be
> changed.

Will do.

Ian
