From: Michael Blandford <michael@kmaclub.com>
Subject: Re: Problem with autofs 3.1.7 -> 4.1.0-beta2
Date: Wed, 10 Dec 2003 21:59:08 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FD7F99C.6030609@kmaclub.com>
References: <Pine.LNX.4.44.0312101829270.3247-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312101829270.3247-100000@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:

>Could you try this patch please.
>
>I'll add it to my source rpm at kernel.org if it works OK for you.
>You will need to grab a src rpm, build it, install the bin, got to the rpm 
>build directory and do make clean, apply the patch, and make then make 
>install. Be aware this will toast youre autofs init script, auto.master 
>and auto.net (if you have changed them.
>
>  
>

I used this patch all day and haven't had any problems with it.  It 
seems good to me.

Michael
