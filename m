From: "Brooks, Jason" <Jason.Brooks@windriver.com>
Subject: Re: Loopback filesystems via autofs
Date: Mon, 24 Mar 2008 15:08:25 -0700
Message-ID: <B4C19C70C5B3F84399FEFE0BB2E264BA31F79F@ala-mail10.corp.ad.wrs.com>
References: <B4C19C70C5B3F84399FEFE0BB2E264BA31F763@ala-mail10.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <B4C19C70C5B3F84399FEFE0BB2E264BA31F763@ala-mail10.corp.ad.wrs.com>
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
To: autofs@linux.kernel.org

Whoops!  I just answered my own question:

1) options loop max_loops <1-255>
2) modify the kernel source no doubt.  1 ought to be enough...

--jason

 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Senior Lab Engineer 
Wind River Systems
8905 SW Nimbus ~ Suite 255	
Beaverton, Or 97008
 

> -----Original Message-----
> From: autofs-bounces@linux.kernel.org 
> [mailto:autofs-bounces@linux.kernel.org] On Behalf Of Brooks, Jason
> Sent: Monday, March 24, 2008 14:42
> To: autofs@linux.kernel.org
> Subject: [autofs] Loopback filesystems via autofs
> 
> Hello,
> 
> I am setting up an iso jukebox on a system.  Other than the 
> /dev/loop* files, is there a limit to the number of loop 
> devices that can be mounted?
> 
> --jason
> 
>  
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Jason Brooks ~ (503) 641-3440 x1861
>       Direct ~ (503) 924-1861
>       Cell   ~ (503) 467-1908
>       jason.brooks@windriver.com
> http://twiki.wrs.com/do/view/Main/JasonBrooks
> http://twiki.wrs.com/do/view/PBUeng/LabOperations
> 
> Senior Lab Engineer
> Wind River Systems
> 8905 SW Nimbus ~ Suite 255	
> Beaverton, Or 97008
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
