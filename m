From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: configure pie problem
Date: Tue, 11 May 2004 13:48:08 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16545.4568.847071.38147@segfault.boston.redhat.com>
References: <Pine.LNX.4.58.0405091113130.15537@donald.themaw.net>
	<16544.53839.846016.786437@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0405112215110.18413@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405112215110.18413@donald.themaw.net>
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

==> Regarding Re: configure pie problem; raven@themaw.net adds:

raven> On Tue, 11 May 2004, Jeff Moyer wrote:
>> Okay, change that -fpie to -fPIE (at least for sparc, don't think it
>> hurts if we do this for everyone).  And I just confirmed with Jakub,
>> that it is better to actually try to run the program:
>> 
>> <jakub> phro: if you have old glibc on sparc, it will compile and link,
>> but not run e.g.
>> 

raven> This would be the final patch on this issue then, yes.

That looks good to me.

Thanks!

Jeff
