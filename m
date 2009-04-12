From: Stef Bon <stef@bononline.nl>
Subject: Re: Automounter stops after reload signal.
Date: Sun, 12 Apr 2009 19:59:57 +0200
Message-ID: <49E22C1D.8030504@bononline.nl>
References: <49DCCD73.5050307@bononline.nl>
	<1239545315.23791.0.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1239545315.23791.0.camel@zeus.themaw.net>
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
> On Wed, 2009-04-08 at 18:14 +0200, Stef Bon wrote:
>   
>> Hello,
>>
>> I've been working on a construction which adds an autofs managed 
>> mountpoint to the homedirectory, when:
>> a. an usb device or more than one is detected when logging in
>> b. an usb device is plugged in during a session
>>     
>
> What version of autofs did you say you are using?
>   

Well, 5.0.4.

I can imagine that my story is complicated, so I've found a simple way 
to get the same behaviour.

Add the following line to the auto.master file in /etc/autofs:

/mnt/smb   /etc/autofs/auto.smb

Start the daemon, or, if already running, do a reload.

Play with the new mountpoint, so do something like :

ls /mnt/smb/<valid name of smb host>

look at the result, a tree should be the result.

Now remove the line again, (thus: "/mnt/smb /etc/a...."), and give the 
daemon a reload again,

and the daemon stops.

I've got a 2.6.27.9 kernel, patched with

autofs4-2.6.27-dev-ioctl-20081029.patch and
autofs4-2.6.27-v5-update-20081027.patch

Stef Bon
