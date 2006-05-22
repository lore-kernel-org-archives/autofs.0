From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS Problems with Laptops
Date: Mon, 22 May 2006 16:07:15 +0800
Message-ID: <44717133.3000304@themaw.net>
References: <20060522075327.23988.qmail@web36807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060522075327.23988.qmail@web36807.mail.mud.yahoo.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Daniel Qarras <dqarras@yahoo.com>
Cc: autofs@linux.kernel.org

Daniel Qarras wrote:
> Hi Ian,
> 
> and thanks for your prompt reply.
> 
>>> I am asking this because I've tried almost everything and I am just
>>> getting bizarre results like directory /var/autofs/(null)/home,
>> -------------------------------------------------------^
>> You'd be running FC5 then.
>> Can't track this down, we shouldn't be getting mount requests from
>> the kernel with no name.
> 
> Yes, the client is FC5, the server is CentOS-4.4. At the server only
> /etc/exports is configured like this:
> 
> /home           10.0.0.0/255.0.0.0(rw,no_root_squash,sync)
> /work           10.0.0.0/255.0.0.0(rw,no_root_squash,sync)
> 
>> A script should just output the map entry without the key. Like
>> -fstype=nfs,rw,soft,intr 10.0.0.1:/work
> 
> Unfortunately, this still creates (null) directory and I can even go to
> /var/autofs/whatever to see contents of /work. And if the script
> outputs both /work and /home I see only either of them, depending the
> order the entries are printed and if they are on the same line or in
> two lines.

That's interesting.

You mean you get a directory "(null)" with no mount?
That shouldn't happen because the the "(null)" key shouldn't be found 
and so shouldn't have a mount entry associated with it. If the script 
needs to return a fail on the lookup it should return 1, 0 on success.

If the script emits a valid mount then it will, of course, mount that.

Ian
