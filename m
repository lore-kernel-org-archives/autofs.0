From: Stef Bon <stef@bononline.nl>
Subject: Re: Question about timeout option.
Date: Mon, 28 Apr 2008 10:08:22 +0200
Message-ID: <481585F6.8080707@bononline.nl>
References: <48148A3A.5070303@bononline.nl>
	<1209311979.7913.37.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1209311979.7913.37.camel@raven.themaw.net>
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
> On Sun, 2008-04-27 at 16:14 +0200, Stef Bon wrote:
>   
>> Hello,
>>
>> 22 april I posted a message with the question about the timeout option.
>>
>> Has anybody read it, and possibly have a clue?
>>     
>
> I read it.
> Try using -browse or browse (not --browse).
>   
Yes, thanks that did it! Somehow the option browse did not get through 
to the daemon.
In my autofs configuration it was set to "no", and the option in the 
master file was ignored.
Now I've set it to yes in the configuration file, and everything is ok.
I'm still looking why this happened.
> It might prevent the top directories from being removed after expire
> (and when you access these it will re-create the sub-directories each
> time so that will be OK) but it wont be able to create the directories
> initially because it's a program map and autofs doesn't have a way to
> ask it for a list of it's keys. I haven't really had any suggestions
> that I think are workable for doing this.
>   
No, I understand. It's not possible to let the automount discover these 
keys, without knowledge
of the map.


Stef Bon
