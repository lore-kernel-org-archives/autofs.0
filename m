From: ramana <ramana@intraperson.com>
Subject: Re: unacceptable bug in autofs kernel module
Date: Fri, 04 Feb 2005 08:29:50 +0530
Message-ID: <4202E526.50304@intraperson.com>
References: <200502040038.j140ck99006468@cornholio.qualcomm.com>
	<Pine.LNX.4.58.0502040948330.21690@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.58.0502040948330.21690@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>, mmarion@qualcomm.com
Cc: autofs@linux.kernel.org

Ian Kent wrote:

>On Thu, 3 Feb 2005 mmarion@qualcomm.com wrote:
>
>  
>
>>On 28 Dec, ramana wrote:
>>
>>    
>>
>>>Here is the bug in autofs3 module which causing so much pain. It simply 
>>>stopped me from adding much more interesting features to Autodir 
>>>http://www.intraperson.com/autodir/
>>>      
>>>
>>[snip]
>>    
>>
>>>Because of this, user space test program reporting like this:
>>>
>>>fail : /test/t944 : No such file or directory
>>>fail : /test/t4187 : No such file or directory
>>>      
>>>
>>Hmm.. I wonder if this might be related to a weirdness we're seeing. Running
>>autofs-4.1.3 with previous latest patch to kernel (pre-2005 release) and users
>>use LSF to submit batch jobs to hosts.  On linux hosts, user level programs
>>will sometimes exit quickly with a "file does not exist" error, even though you
>>can login to the host and see the file/dir just fine.  As a hacked
>>work-around, we have a pre-exec script that tries to stat all the directories
>>they need to force the mounts to happen before their program touches the
>>files.
>>    
>>
>
>Does the stat actually mount anything?
>It shouldn't?
>
>Ian
>
>
>  
>
I moved latest version Autodir to autofs 4 kernel module and so far all 
stress tests tell me autofs4 protocol is performing well without these 
ENOENT errors. I have to do little bit more tests before concluding 
anything as final.

For more details check http://www.intraperson.com/autodir/.
DVersion: Autodir 0.93.0 and above.

Regards
ramana

-- 
http://www.intraperson.com
