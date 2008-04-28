From: Stef Bon <stef@bononline.nl>
Subject: Re: Add mountpoints to mastermap dynamically.
Date: Mon, 28 Apr 2008 17:39:05 +0200
Message-ID: <4815EF99.7070105@bononline.nl>
References: <4815DC61.1080501@bononline.nl>
	<x49zlredp14.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49zlredp14.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Jeff Moyer wrote:
> Stef Bon <stef@bononline.nl> writes:
>
>   
>> Hello,
>>
>> again a question.
>>
>> The construction I'm working on does add a mountpoint dynamically to an 
>> existing map.
>>     
>
> The subject says you're adding a new entry to the master map.  This
> sentence sounds like you're adding an entry to an existing map.  The
> second should be caught automatically by the daemon, so no need to
> reload.
>   
Ok,

I mean the first: adding a new entry to the master map.
>   
>> After added (first some checking the mountpoint is not already included) 
>> a reload is
>> done with the running automount (HUP signal). The same after removing a 
>> mountpoint.
>>
>> It works very good, but I'm wondering, is this the way to do this??
>> Isn't there a autofsctl program???
>>     
>
> You could do, 'service autofs reload' instead.  Or maybe you should
> investigate direct maps.  I'm not sure, since I know very little of your
> setup.
>   
Yes, but my system does not know a  "service" command. (LFS/BLFS). I 
think this command
service is typical Red Hat isn't it?

I have to give the init script the command "reload" directly:

/etc/rc.d/init.d/autofs reload

It has the same effect.


Stef Bon
