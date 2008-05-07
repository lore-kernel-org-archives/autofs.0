From: Stef Bon <stef@bononline.nl>
Subject: Re: Some reload problems.
Date: Wed, 07 May 2008 18:01:37 +0200
Message-ID: <4821D261.8090600@bononline.nl>
References: <481F1623.1050505@bononline.nl>	<1209999972.2768.8.camel@raven.themaw.net>
	<4820299C.7000907@bononline.nl>
	<1210165881.8830.6.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1210165881.8830.6.camel@raven.themaw.net>
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
Cc: autofs@linux.kernel.org

Ian Kent wrote:
>> May  6 11:32:15 localhost automount[5773]: autofs stopped
>>
>> So this is what happens.
>>     
>
> So, autofs just exits.
>
> The problem is that autofs needs to know when to exit and that amounts
> to checking if any active mounts are left. But that check breaks down
> because we need to avoid it unless we've actually been asked to shutdown
> and, at the moment, this isn't known to the function that does the
> check. The condition is checked every time a mount point shuts down.
>
> I think I can fix this fairly easily but, for it to be a simple fix, we
> will need a patch I'm working on to be merged first.
>
> So you're stuck, for a while anyway.
>   

Well I'm not really stuck. The way I've solved it is to add another 
mountpoint to /etc/autofs/auto.master
which remains there. Then there is no problem.

And I can wait.

Thank you for looking to this problem.
With all these steps I hope I can create a contruction which allows a 
more powerfull access to network resources
than there exist today.

Stef Bon
