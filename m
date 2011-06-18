From: James Pearson <james-p@moving-picture.com>
Subject: Re: Odd NIS map failure with mount point creation time in
 the future?
Date: Sat, 18 Jun 2011 16:59:06 +0100
Message-ID: <4DFCCB4A.4030900@moving-picture.com>
References: <4DFB60C1.4080801@moving-picture.com>
	<1308392316.12881.14.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1308392316.12881.14.camel@perseus.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
>>
>>Any idea why autofs fails to read entries from the included NIS map when 
>>the creation date of the map mount point is in the future? - but works 
>>fine when the same NIS map is referenced directly from /etc/auto.master?
> 
> 
> Don't know about the timestamp but there were some included map fixes in
> RHEL-5.7, at least one was a fix for a regression.
> 
> Versions?

Sorry, I should have said - this is CentOS 5.5 with autofs 
5.0.1-0.rc2.143.el5_5.6 - and I've also tried it with 
5.0.1-0.rc2.143.el5_6.2 - with the same result.

It is easy to reproduce - with an included NIS map - if I do:

/etc/init.d/autofs stop; date -s "1 minute"; /etc/init.d/autofs start; 
date -s "-1 minute"

This creates the automount mount point 1 minute into the future.

Then if I try to access a server defined in the NIS map, the mount fails.

However, if I wait a minute (i.e until the system clock passes the date 
stamp of the mount point), the automount of file systems in the NIS map 
works fine.

Is it possible to get a copy of the autofs RPM for RHEL-5.7 to test?

Thanks

James Pearson
