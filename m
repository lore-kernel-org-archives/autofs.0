From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] 5.0.0_beta1: glibc 2.4.0 quirk
Date: Wed, 26 Sep 2007 23:11:53 +0800
Message-ID: <1190819513.12109.7.camel@raven.themaw.net>
References: <200709261103.19490.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200709261103.19490.vda.linux@googlemail.com>
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
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-09-26 at 11:03 +0100, Denys Vlasenko wrote:
> hi Ian,
> 
> I have glibc 2.4.0 installed, and it expands pthread_cleanup_pop(1) into:
> 
> 	} while (0); __pthread_unregister_cancel (&__cancel_buf); if (1) __cancel_routine (__cancel_arg); } while (0);
> 
> This doesn't compile if you have a label before it.
> gcc 4.2.1 says "error: label at end of compound statement".
> 
> This patch works around it by adding extra semicolon.

Cool, I'll test this out and commit it.
Thanks
