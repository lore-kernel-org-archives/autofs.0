From: Ian Kent <ikent@redhat.com>
Subject: Re: Autofs dump map option
Date: Sat, 06 Aug 2011 16:54:49 +0800
Message-ID: <1312620890.3304.1.camel@perseus.themaw.net>
References: <4E3BB3C8.9040305@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4E3BB3C8.9040305@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.com>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Fri, 2011-08-05 at 11:11 +0200, Ondrej Valousek wrote:
> Hi Ian,
> 
> Thanks for looking after the bugs #538408 and #704416 for me, but I
> have one slight problem with it:
> Automouter won't show any keys in my indirect NIS maps unless I
> specify "BROWSE_MODE=yes".
> Maybe it is expected behaviour so I was thinking - can we always force
> browse_mode when dumping maps?
> 
> Sorry for spotting this too late.

Ha, I'll have a look and see what we need to do.

I'm on leave between the 8th and 13th and will have limited internet
connectivity so I likely won't be able to do much until I get back.

> 
> Thanks,
> Ondrej
> 
> 
> ______________________________________________________________________
> The information contained in this e-mail and in any attachments is
> confidential and is designated solely for the attention of the
> intended recipient(s). If you are not an intended recipient, you must
> not use, disclose, copy, distribute or retain this e-mail or any part
> thereof. If you have received this e-mail in error, please notify the
> sender by return e-mail and delete all copies of this e-mail from your
> computer system(s). Please direct any additional queries to:
> communications@s3group.com. Thank You. Silicon and Software Systems
> Limited (S3 Group). Registered in Ireland no. 378073. Registered
> Office: South County Business Park, Leopardstown, Dublin 18 
> 
> ______________________________________________________________________
> 
