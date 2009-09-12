From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: autofs does not umount
Date: Sat, 12 Sep 2009 16:40:35 +0100
Message-ID: <20090912154035.GH5858@ZenIV.linux.org.uk>
References: <20090827222825.GA23043@merfinllc.com>
	<20090827232753.GA26300@merfinllc.com>
	<4A971D47.3050503@themaw.net>
	<20090828001545.GA28811@merfinllc.com>
	<alpine.LFD.2.00.0908281018420.21701@zeus.themaw.net>
	<4A976E14.7000301@themaw.net> <20090828164358.GA6935@merfinllc.com>
	<4A9B456C.2070607@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A9B456C.2070607@themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>, Aaron Straus <aaron@merfinllc.com>

On Mon, Aug 31, 2009 at 11:37:16AM +0800, Ian Kent wrote:
> Aaron Straus wrote:
> > Hi,
> > 
> > On Aug 28 01:41 PM, Ian Kent wrote:
> >>> -	if (!may_umount_tree(mnt)) {
> >>> +	if (!may_umount_tree(&path.mnt)) {
> >> My bad, sorry.
> >> I think that really should be path.mnt not &path.mnt.
> > 
> > Yep.  I confirm the fixed-up patch fixes the problems I'm seeing.
> 
> Al,
> 
> Would you like me to post my corrected patch to LKML (to akpm or ??) or
> would you like to take care of it?

My apologies, both for the original breakage and late reply ;-/
Along with belated ACK on the fix.
