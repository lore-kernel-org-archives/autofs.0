From: Richard Smits <R.Smits@tudelft.nl>
Subject: Re: Two different security flavours in nfs mount
	auto.master
Date: Mon, 26 Apr 2010 12:55:50 +0200
Message-ID: <4BD57136.80601@tudelft.nl>
References: <4BD5475B.4040106@tudelft.nl> <1272277816.16431.64.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1272277816.16431.64.camel@localhost>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org
Cc: Ian Kent <raven@themaw.net>

Ian Kent wrote:
> On Mon, 2010-04-26 at 09:57 +0200, Richard Smits wrote:
>> Hello,
>>
>> I was wondering if the next example would be possible with the 
>> automounter. I have a feeling this is not possible, but maybe there are 
>> some options I do not know about.
>>
>> I have two nfs servers.
>>
>> One with /export with standard nfs export.
>>
>> One with /export with krb5 security.
>>
>> Now I want to moutn one of the two if a condition is met. The condition 
>> I check with the excecutable automounter script.
>>
>> That is not my problem.
>>
>> The problem is the auto.master file. For a directory, I can have one 
>> security flavour. This is my problem. I need two. See below :
>>
>> # NFS homedirs
>> /home/nfs	/etc/auto.nfs -rw,-fstype=nfs --timeout 60
>>
>> /home/nfs is the homedir for the user, I cannot change this because this 
>> is in the configuration os samba. (We use winbind for authentication).
>>
>> But my auto.nfs script checks if the user has a homedir on the sandard 
>> nfs3 server, or has a home on our nfs4/krb5 server.
>>
>> But my auto.master isn't ready for this if you know what I mean.
>>
>> I need :
>>
>> # NFS homedirs
>> /home/nfs	/etc/auto.nfs -rw,-fstype=nfs --timeout 60
>> /home/nfs	/etc/auto.nfs -rw,-fstype=nfs4,sec=krb5 --timeout 60
> 
> Why don't you just return the required options from the program mount
> script along with the mount location?
> 
> You can see an example of this in /etc/auto.net and in /etc/auto.smb. In
> its simplest form it's just "-<comma separated opts> <mount location>"
> and get rid of the -fstype option from the master map.

Yes, this was exacly what I was looking for. Thank you for this good 
tip. I did not know this was possible. I got it working now.

Thanks again.

Greetings .. Richard
