From: Ian Kent <raven@themaw.net>
Subject: Re: 2.6 patches broken with 2.6.4
Date: Fri, 12 Mar 2004 09:16:17 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403120910270.7863@wombat.indigo.net.au>
References: <Pine.LNX.4.44.0312022129550.2970-100000@raven.themaw.net>
 <4050BE51.6010908@yahoo.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4050BE51.6010908@yahoo.com>
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
To: Alexander Macdonald <alexandermacdonald@yahoo.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 11 Mar 2004, Alexander Macdonald wrote:

> The patches have applied cleanly to all kernels up to now, however the second 
> patch (and maybe more, didn't try them since there wasn't any point) won't apply 
> cleanly to kernel 2.6.4.

I'll look into it this weekend.

> 
> I don't know about anybody else's experience with these patches but I haven't 
> had any trouble with them at all, maybe you should send them to Andrew Morton 
> for inclusion in the -mm branch, That'd save me some patching time for each 
> kernel ;)

Thanks for the feedback. How long and in what environment have you been 
using them.

I've done that some time ago. As far as I knon he hasn't included them 
yet.

I've been wanting to revise the wait queue locking anyway as I'm sure 
it's open to a race.

Ian
