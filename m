From: ramana <ramana@intraperson.com>
Subject: Re: unacceptable bug in autofs kernel module
Date: Wed, 29 Dec 2004 09:14:10 +0530
Message-ID: <41D2280A.2090502@intraperson.com>
References: <41D1106C.9070706@intraperson.com>
	<Pine.LNX.4.58.0412290843030.31988@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0412290843030.31988@wombat.indigo.net.au>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>, autofs@linux.kernel.org

Ian Kent wrote:

>On Tue, 28 Dec 2004, ramana wrote:
>
>  
>
>>Dear developers,
>>
>>Here is the bug in autofs3 module which causing so much pain. It simply 
>>stopped me from adding much more interesting features to Autodir 
>>http://www.intraperson.com/autodir/
>>    
>>
>
>Thanks for this.
>
>You've provided some symptoms but you haven't provided any explanation as 
>to why this is a bug.
>
>Can you explain why you need the kernel to honour a lookup for an already 
>deleted dentry?
>  
>

If it it is deleted then it should cleanup if any and report back to the 
user space autofs/autodir daemon again that this directory is missing 
instead of directly reporting that entry does not exist because it is 
deleted. After all that is what autofs is all about.

What is important is that -t option is user settable option. If the user 
choses low value like 1 or 2 seconds these autofs directories will be 
deleted more frequently. But deletion does not mean they do not exist 
actually.

It it certainly bug. Let us view from user space application which is 
accessing these autofs directories. Most of the time they get access to 
the directories which exist and perfectly legal. And suddenly at some 
time kernel decides itself and reports it does not exist even without 
asking user space autofs/autodir daemon.

What is important here is, after a while, if I access it again after 
ENOENT, everything works perfectly. Is not this inconsistent behavior?

Above statement is true as I tested it from user space applications for 
millions of directory requests rather then looking from kernal point of 
view. If I access a autofs directory for 999 times and I get ENOENT for 
1 time without proper reason from user space daemon, it is certainly bug.

Thanks for your reply.

>This could be due to the way that autofs does a d_drop instead of a 
>d_delete in the directory unlink callback. However, the dentry, for all 
>intentional purposes, has already been deleted.
>
>  
>

Regards
ramana

-- 
http://www.intraperson.com
