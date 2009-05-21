From: Ian Kent <raven@themaw.net>
Subject: Re: HOST expansion with autofs+LDAP
Date: Thu, 21 May 2009 22:38:19 +0800
Message-ID: <4A15675B.5090307@themaw.net>
References: <20090512154529.9FC3313ED0@wsnyder.org>
	<4A0A4BCC.4030702@themaw.net> <4A0A57E0.3010601@themaw.net>
	<20090521140333.A048214477@wsnyder.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090521140333.A048214477@wsnyder.org>
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
To: Wilson Snyder <wsnyder@wsnyder.org>
Cc: autofs@linux.kernel.org

Wilson Snyder wrote:
>> Ian Kent wrote:
>>> Wilson Snyder wrote:
>>>> I have a suse10.3 system which includes autofs-5.0.2-30.2
>>>>
>>>> I'd like an LDAP entry that makes an autofs mountpoint that
>>>> includes the local host's name.  If this wasn't under LDAP I
>>>> believe "/net/$HOST" would work - creating a
>>>> "/net/{name-of-hostname}" mountpoint.
>>>>
>>>> However, if I add a mountpoint with cn=$HOST
>>>>
>>>> cn=$HOST,nismapname=auto.net,dc=company,dc=com
>>>>
>>>> The automounter nicely makes a "/net/$HOST" mount -
>>>> *literally* /net/$HOST, that is it doesn't expand $HOST to
>>>> the hostname.
>>>>
>>>> Same thing if I use cn=${host}
>>>>
>>>> Any hints?  Thanks! 
>>> Oddly enough I think that $HOST should be expanded but I have no idea
>>> how you think this is supposed to work because you haven't provided any
>>> information about the LDAP entry, other than the dn, or provided any
>>> debug log information.
>> Sorry, that isn't correct.
>> Macro expansion is not done on keys and never has been.
>>
>> Which begs the question, is it sensible to do macro expansion on keys
>>from a map before trying to match them against the key string received
>>from the kernel for the lookup?
> 
> I'm not sure if I'm decoding the question properly, but I
> suspect it's fast enough to expand on the fly, as that's
> more flexible, but either way works for my application since
> HOST is (well is generally) constant.

Your not interpreting my statement quite right.
The "between the lines" meaning is "question to self; should I allow
this, if not why not"!

Anyway, I haven't got time to ponder that just yet, except for below.

> 
> Can you point me to the right place in t the 5.0.2 sources
> to patch this in? I see the expansion code in parse_mount
> but am not sure what the best place to call it from is.

Mmmm ... it's the "key" so one reason why you might find it difficult is
that you need to "lookup" the string you get from the kernel as a key in
the map source, for example NIS or LDAP, but you can't look it up if the
key in the map source needs to be translated in order to match. Catch 22.

There is just no way that we will do a linear search for every lookup.
Consider what that would mean to someone with a map of more that 6 or 8
thousand entries.

Things start to get more complicated from here on with regard to this
question.

Ian
