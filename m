From: raven@themaw.net
Subject: Re: Help with automounting from a LDAP server
Date: Wed, 12 Jan 2005 23:34:33 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501122317470.8319@donald.themaw.net>
References: <87llb1oi7g.fsf@tango.dre.vanderbilt.edu>
	<Pine.LNX.4.58.0501101645100.5722@wombat.indigo.net.au>
	<87pt0czb00.fsf@tango.dre.vanderbilt.edu>
	<Pine.LNX.4.58.0501111631590.7845@wombat.indigo.net.au>
	<20050111102356.0709bcef@localhost>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050111102356.0709bcef@localhost>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: abo <abo@brujulatelecom.com>
Cc: autofs@linux.kernel.org

On Tue, 11 Jan 2005, abo wrote:

> sorry about this newbie question, but can you explain what exactly
> direct mounts/maps is?

That's a little difficult but ...

An example of an indirect map might be:

in the master map

/home	/etc/auto.indirect

and auto.indirect might have

user1	server1:/home/userdir1
user2	server1:/home/userdir2
....

An example of a direct map might be:

/-	/etc/auto.direct

and in auto.direct might have

/nfs/apps/geoapp1	server1:/apps/geoapplication
/nfs/apps/geoapp2	server2:/apps/application2
/nfs/data/mydata	data1:/data/north/mydata
/global/data/theirdata	other:/data/test
...

Direct mount maps always have /- in the master map whereas indirect maps 
always have their base directory.
Direct mount keys are always full paths wheras in an indirect mount the 
key is always a single directory component.

You can't have nested mounts in a direct map either.

Check out Managing NFS and NIS 2nd edition, O'Reilly, chapter 13.

>
> thx
>
>
> On Tue, 11 Jan 2005 16:39:40 +0800 (WST)
> Ian Kent <raven@themaw.net> wrote:
>
>> On Tue, 11 Jan 2005, Krishnakumar B wrote:
>>
>>>> Can't do that at present.  Direct mounts are not fully
> implemented.
>>>
>>> My manpage for autofs(5) claims the following:
>>>
>>> UNSUPPORTED
>>>        This version of the automounter supports direct maps for
> FILE, NIS
>>>        and LDAP maps only and handles SunOS-style replicated
> filesystems
>>>        only to the extent that mount(8) does.
>>
>> Perhaps I need to change this to be more accurate.
>>
>>>
>>> So is my manpage wrong, or does "direct maps" mean something other
> than
>>> "direct mounts"?  Or are you referring to the following limitation
> (from
>>> README.direct v1.3).
>>>
>>> NOTE: Due to current design limitations, direct maps will take over
> an
>>> entire directory hierarchy.  What this means is, if your direct map
> key is
>>> /usr/share/bilbo, then /usr will become an automount mount point,
> mounting
>>> over the existing /usr.
>>
>> I'm refering to the design limitation mentioned in this note.
>>
>> This will continue to be the case in 4.1.4 (in fact 4.1.x).
>>
>> I plan on creating a 4.2.0 development branch at some point fairly
> soon.
>> This will be the top priority for that development.
>>
>> Ian
>>
>> _______________________________________________
>> autofs mailing list
>> autofs@linux.kernel.org
>> http://linux.kernel.org/mailman/listinfo/autofs
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
