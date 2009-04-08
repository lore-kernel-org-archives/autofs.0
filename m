From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch] unlock_kernel() in autofs
Date: Wed, 8 Apr 2009 16:00:04 +0300
Message-ID: <a63d67fe0904080600x2f4186b8s161679a612e864e5@mail.gmail.com>
References: <alpine.DEB.2.00.0904070829180.522@bicker>
	<49DC46DF.4080908@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49DC46DF.4080908@themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, hpa@zytor.com

On 4/8/09, Ian Kent <raven@themaw.net> wrote:
> Dan Carpenter wrote:
>> There are a couple missing unlock_kernel() calls on error paths in autofs
>> version 2.6.29.
>
> Hi Dan,
>
> Thanks for your patch.
>
> You may not be aware but the autofs4 kernel module may satisfy your
> needs and it is actively maintained whereas I haven't been paying much
> attention to the autofs module for some time now.

No problem.  I'm just randomly sending patches for my allyesconfig.

>>
>> Found by smatch (http://repo.or.cz/w/smatch.git).  Compile tested.
>
> Source code analysis?
> Is there a home page or download?
>

You can download it from http://repo.or.cz/w/smatch.git.  There are
tar balls available as well on the right hand side of the page.  It's
still pretty rough and has too many false positives, but it's easy
enough to test...

make
cd /usr/src/kernel
make C=1 CHECK=/path/to/smatch fs/autofs/root.c | egrep '(warn|error):'

regards,
dan carpenter
