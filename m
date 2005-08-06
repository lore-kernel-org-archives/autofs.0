From: Ian Kent <raven@themaw.net>
Subject: Re: Here's a new really odd auto.net bug
Date: Sat, 6 Aug 2005 22:07:59 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0508062203390.2086@donald.themaw.net>
References: <200508052107.j75L7Tid019987@crowley.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200508052107.j75L7Tid019987@crowley.qualcomm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

On Fri, 5 Aug 2005, Mike Marion wrote:

> On  4 Aug, Michael Marion wrote:
> 
> > Trying some more things...
> 
> Turns out it was my fault again.. I seem to have built the daemon for
> sles9-sp1 and sp2 and missed one of the patches.  I rebuilt it again to make
> damn sure I hadn't, and the new build works properly. 
> 
> Don't know how I missed a patch when I built it for the suse9.2 host at the
> same time and didn't miss it.
> 
> I'm thinking those 3 patches need to be rolled into the main codebase.

Yep. I need to get back to working on 4.1.

Which three?

I've got four waiting to go into a new revision but the three you are 
refering to may be older still.

Ian
