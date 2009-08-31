From: Ian Kent <raven@themaw.net>
Subject: Re: autofs does not umount
Date: Mon, 31 Aug 2009 11:37:16 +0800
Message-ID: <4A9B456C.2070607@themaw.net>
References: <20090827222825.GA23043@merfinllc.com>
	<20090827232753.GA26300@merfinllc.com>
	<4A971D47.3050503@themaw.net>
	<20090828001545.GA28811@merfinllc.com>
	<alpine.LFD.2.00.0908281018420.21701@zeus.themaw.net>
	<4A976E14.7000301@themaw.net> <20090828164358.GA6935@merfinllc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090828164358.GA6935@merfinllc.com>
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
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: autofs mailing list <autofs@linux.kernel.org>, Aaron Straus <aaron@merfinllc.com>

Aaron Straus wrote:
> Hi,
> 
> On Aug 28 01:41 PM, Ian Kent wrote:
>>> -	if (!may_umount_tree(mnt)) {
>>> +	if (!may_umount_tree(&path.mnt)) {
>> My bad, sorry.
>> I think that really should be path.mnt not &path.mnt.
> 
> Yep.  I confirm the fixed-up patch fixes the problems I'm seeing.

Al,

Would you like me to post my corrected patch to LKML (to akpm or ??) or
would you like to take care of it?

Ian
