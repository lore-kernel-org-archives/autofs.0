From: Ian Kent <raven@themaw.net>
Subject: Re: autofs does not umount
Date: Fri, 28 Aug 2009 07:56:55 +0800
Message-ID: <4A971D47.3050503@themaw.net>
References: <20090827222825.GA23043@merfinllc.com>
	<20090827232753.GA26300@merfinllc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090827232753.GA26300@merfinllc.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Aaron Straus <aaron@merfinllc.com>
Cc: autofs@linux.kernel.org, viro@zeniv.linux.org.uk

Aaron Straus wrote:
> On Aug 27 03:28 PM, Aaron Straus wrote:
>>   I was testing kernel 2.6.31-rc7 and noticed that autofs4 doesn't seem
>> to be umounting file systems anymore.  
>>
>>   In particular after the timeout expires file systems seem to stay
>> mounted.  Furthermore if I do a umount of the file system by hand it
>> works i.e. the file system isn't busy.  Also sending a USR1 signal to
>> the automount process does not cause an umount either.
>>
>>   I've initially observed this behavior with NFS mounts, but set up just
>> a single, local bind mount (in the automount tables) and the bad
>> behavior is still there.
>>
>>   I reverted to 2.6.30.5 and automount works as expected.  This is on a
>> Ubuntu Hardy system running the autofs 4.1.4+debian-2.1ubuntu1 package.
>>
>>   Anybody else having this problem?  Any additional info I can provide?
> 
> Update.  Bisection seems to yield this as the first bad commit:
> 
> commit 9393bd07cf218ca51d0e627653f906a9d76a9131
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Sat Apr 18 13:58:15 2009 -0400
> 
>     switch follow_down()
>     
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

That commit certainly looks OK, a straight conversion to use struct path.

How about a debug log from autofs so we can try to find out what bit is
actually going wrong.

Ian
