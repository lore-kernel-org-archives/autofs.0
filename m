From: Hans Deragon <hans@deragon.biz>
Subject: Re: backfstype patch.
Date: Wed, 30 Jun 2004 11:11:30 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40E2D822.7020609@deragon.biz>
References: <40E1CCC3.1010809@deragon.biz> <40E2C0BA.3070605@sun.com>
 <16610.50525.858094.848839@segfault.boston.redhat.com>
 <40E2CC43.1060001@sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <40E2CC43.1060001@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Cc: autofs@linux.kernel.org

Mike Waychison wrote:
>>Michael.Waychison> Why do this in the parser when it can easily be done in
>>Michael.Waychison> a mount module?
>>
>>Care to expound a bit?  I'm not sure what people use backfstype for,
> 
> but if
> 
>>it is generic, then you wouldn't want to handle every case in every mount
>>module.  But I think I'm missing your point.
>>
>>It makes some sense to me to handle this above the mount module, simply
>>because you could call into two different modules.
>>
>>So, care to set me straight?  ;)
>>
>>-Jeff
> 
> 
> I'm CC'ing David as he may have a better view of what the cachefs status is.
> 
> Backfstype is a fstype=cachefs specific mount option.  Specifically:
> 
>  - add cachefs to the not_generic array in daemon/mount.c
>  - create a new mount module, modules/mount_cachefs.c.  This module
> would check for cachefs support available and use it if available.
> Otherwise it would rewrite the fstype with the backfstype mount option
> and call do_mount again.
> 
> - --
> Mike Waychison
> Sun Microsystems, Inc.
> 1 (650) 352-5299 voice
> 1 (416) 202-8336 voice
> http://www.sun.com

Great.


   Is this issue in someone's else hands?  The reason I coded the solution in 
parse_sun.c is simply because I know nada about automount and I wanted a quick 
solution.  I did not take the time to study automount's architecture to 
understand the big picture, and I won't have the time to do this either. :( 
Worse, I do not know much about C coding and particularly the available API for 
Linux system calls.  However, I would like to see some solution taking care of 
backfstype being implemented in the next release.  Can someone please take the 
initiative?  You guys seam to understand the issue much better than I.


Best regards,
Hans Deragon
--
Consultant en informatique/Software Consultant
Deragon Informatique inc.     Open source:
http://www.deragon.biz        http://facil.qc.ca (Promotion du libre)
mailto://hans@deragon.biz     http://autopoweroff.sourceforge.net (Logiciel)
