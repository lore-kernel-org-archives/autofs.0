From: Ian Kent <raven@themaw.net>
Subject: Re: Replicated hosts in autofs v4.
Date: Tue, 12 Oct 2004 09:37:44 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410120935520.32308@wombat.indigo.net.au>
References: <bf092570041010091873f86c2f@mail.gmail.com>
 <200410110053.40587.vda@port.imtp.ilyichevsk.odessa.ua>
 <16746.42133.679569.866410@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16746.42133.679569.866410@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, 11 Oct 2004, Jeff Moyer wrote:

> 
> Not true.  Solaris behaves quite as you would expect in these cases:
> 
>  Server proximity takes priority in the  selection  process.
>      In  the  example  above,  if the server delta is on the same
>      network segment as the client, but the others  are  on  dif-
>      ferent  network  segments,  then delta will be selected; the
>      weighting value is ignored.  The weighting has  effect  only
>      when selecting between servers with the same network proxim-
>      ity.

Mike, can we define "proximity" and "same network segment" as used in the 
Solaris automounter please (if that's possible).

Ian
