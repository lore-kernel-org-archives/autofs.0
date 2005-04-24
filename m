From: raven@themaw.net
Subject: Re: Re: [daniel@vision.ime.usp.br: Bug#304245: patch - NFS
	mounts occasionally fail]
Date: Sun, 24 Apr 2005 17:32:52 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504241728230.20970@donald.themaw.net>
References: <20050417154240.GA17232@uio.no>
	<20050417181827.GA13101@vision.ime.usp.br>
	<Pine.LNX.4.62.0504182142090.14946@donald.themaw.net>
	<42640E89.7090005@redhat.com>
	<Pine.LNX.4.62.0504241602310.18935@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504241602310.18935@donald.themaw.net>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Chris Feist <cfeist@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, daniel@vision.ime.usp.br

On Sun, 24 Apr 2005 raven@themaw.net wrote:

> On Mon, 18 Apr 2005, Chris Feist wrote:
>
>>  I've attached the redhat patch which should fix this problem as well. 
>>  (And we've tested it and it seems to work pretty well).
>> 
>>  Thanks,
>>  Chris
>> 
>>  raven@themaw.net wrote:
>> >   On Sun, 17 Apr 2005, Daniel Andre Vaquero wrote:
>> > 
>> > >   Hi,
>> > > 
>> > >   My editor broke the indentation style in the patch; I'm resending it 
>> > >   as
>> > >   an attached file.
>> > 
>> > 
>> >   Will check out the patch.
>> > 
>> >   Thanks for the feedback.
>
> Hi guys,
>
> I've reviewed the two patches submitted regarding this problem.
>
> Thanks for your efforts Daniel but the patch that Chris has submitted covers 
> the issue that you reported and addresses a couple of other things as well.
>
> Thanks Chris, I'll merge the patch and copy it up to kernel.org.
>
> There was however one thing that Daniel pointed out that I added to your 
> patch (hunk below). That is the selection of the first multi-mount entry if 
> all else fails. I know that this was changed due to excessive mount delays 
> but as your patch avoids the ping altogether for single entries and the doco 
> says it behaves this way I expect it will be OK. If not I'll revert it.
>

Ooops. Spotted something else.

The function is_multimount_entry should use a || as multi-mount entries 
can be like:

host1,host2:/path

or

host1:/path host2:/path

or a combination.

Ian
