From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Horrible denial of service bug in autmount 5
Date: Fri, 20 Jun 2008 16:24:01 +0100
Message-ID: <095037D1-F2F1-4A08-A6D2-841C22D8BC5C@cam.ac.uk>
References: <8332BEF1-7FA5-434F-B444-9F8820A61B83@cam.ac.uk>
	<1213969464.2971.107.camel@raven.themaw.net>
	<5A1DEB9E-FD94-455E-AB89-05D9E74084B5@cam.ac.uk>
	<1213974299.4975.15.camel@raven.themaw.net>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1213974299.4975.15.camel@raven.themaw.net>
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
Cc: autofs@linux.kernel.org, Unix Support <unix-support@ucs.cam.ac.uk>, hpa@zytor.com

Hi,

On 20 Jun 2008, at 16:04, Ian Kent wrote:
> On Fri, 2008-06-20 at 15:01 +0100, Anton Altaparmakov wrote:
>> On 20 Jun 2008, at 14:44, Ian Kent wrote:
>>> On Fri, 2008-06-20 at 14:24 +0100, Anton Altaparmakov wrote:
>>>> The autofs 5.0.2 package that comes with opensuse 10.3 has a nasty
>>>> denial of service attack in the automount daemon.  I can only  
>>>> assume
>>>> that the code comes from the actual autofs source rather than being
>>>> introduced by opensuse but I could be wrong (I haven't checked).
>>>>
>>>> The bug is that automount searches /proc/*/cmdline for a substring
>>>> that matches "automount" and refuses to run if it finds such a  
>>>> thing.
>>>>
>>>> So any user that just does:
>>>>
>>>> cat > automount.c <<EOD
>>>> int main(void)
>>>> {
>>>> 	sleep(10000);
>>>> 	return 0;
>>>> }
>>>> EOD
>>>> gcc -o automount.c
>>>> export PATH=.;$PATH
>>>> automount
>>>>
>>>> And now no-one can run the real automount including root!
>>>>
>>>> Even if this was not a DoS waiting to happen, why do you have this
>>>> check in the code?  There is no reason whatsoever to try and  
>>>> restrict
>>>> people from running multiple instances of the automount process...
>>>
>>> Really, the fact that you think no-one will ever attempt to run
>>> automount again, perhaps by accidentally starting the application  
>>> when
>>> it is already running, using the same configuration shows you  
>>> haven't
>>> really thought about this issue.
>>
>> And so what?  The previous automount binary did not do this check
>> either.  Lots of people use multiple invocations of the automounter  
>> in
>> all sorts of scenarios and you are gratuitously breaking all of those
>> applications or making them rather annoying.
>>
>> But most importantly you are creating a DoS in your application
>> because ANY user can run the example code I showed in my original  
>> post
>> and thus stop the real automount process from running.
>>
>> I am sorry but this is Unix.  You are not allowed to protect people
>> from shooting themselves in the foot.  That's what init scripts are
>> for!  I have never seen such a stupid check in a daemon before!
>
> Ummm ... rubbish ... and rubbish and yeah the check is inconvenient  
> but
> not as bad as you claim.

Sorry but it is worse than you make out, too.  Why don't you try  
running the snippet I posted as a normal user and after that try to  
restart the automounter for example?  You will notice it will fail  
telling you that it is already running even though it is not.

If the start (or restart) had been done automatically as part of  
installing an updated rpm then suddenly you have a potentially broken  
server (think of automounted home directories for example which is  
what we have).

And there are plenty of people who set their servers to update  
automatically during the night.  (And no I am not one of them!)

> I'm allowed to try and protect people from doing things that aren't
> sensible if I wish to, "it is Unix" as you say.

Yes, sorry.  I meant to write that it is against Unix Philosophy not  
that you are not allowed to do it.  (Brain to keyboard translation  
error. - It is Friday!)

>>>> We in fact run one automount instance for each logged in user on  
>>>> our
>>>> Linux distribution for Cambridge University. - We now have to play
>>>> silly buggers with running automount in such a way as to replace  
>>>> its
>>>> argv[0] with a different string so we can run multiple instances.
>>>>
>>>> But that still leaves the DoS attack that any user can run a  
>>>> program
>>>> as above and no-one else will be able to log in any more as the
>>>> automount process will find the literal string "automount" from the
>>>> user's executable...
>>>>
>>>> So we would really like the complete abomination that is autofs/
>>>> daemon/
>>>> automount.c::is_automount_running() thrown away or at least made
>>>> optional with a command line option if you insist on having it,
>>>> pretty
>>>> please with sugar on top?
>>>
>>> The tone of your mail is lousy, given that your asking for something
>>> and
>>> haven't offered a patch to support your request and haven't really
>>> thought about the issue and haven't even offered any suggestions  
>>> about
>>> alternative approaches.
>>
>> You need a patch to delete a few lines of code?  Wow!  I expected you
>> to be able to do it yourself!
>>
>> And I did suggest two alternative approaches...  Reread my above
>> paragraph.  It clearly states that completely removing the
>> is_automount_running() function and its call site is one approach and
>> another one is to provide a command line option to bypass execution  
>> of
>> this code but that does not solve the DoS issue so only removal of  
>> the
>> code is a real solution.
>
> Removing the function isn't a solution that I'm willing to accept, in
> fact it isn't a solution at all, and since it's so simple you can  
> easily
> do it yourself and spend the time you save on coming up with a  
> sensible
> suggestion.
>
>> Looking for literal strings in /proc is nothing short of stupid!  I  
>> am
>> sorry for you and your users if you can't see that...
>
> I never said that you point was not well taken.
>
> I said I didn't like your tone, given that you were asking for  
> something
> and that continues to be the case. If you think that posting using  
> this
> tone will get priority for fixing this then you are sadly mistaken.

I don't care if you fix it as we are stuck with opensuse 10.3 now for  
the next year and I doubt very much that sort of change would filter  
through...  And we have a workaround by running the automounter using:

perl -e 'exec {"automount"} @ARGV' pwf-amnt ...

Which means that in /proc/*/cmdline the string that appears is "pwf- 
amnt" (as we override argv[0] in the exec call to that effect) thus  
the is_automount_running() function does not find the literal string  
"automount" in there and we can run it as many times as we want (which  
is once per user).

However I think you should fix it because it is a DoS on all servers  
using this daemon for automounting anything important...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
