From: James Pearson <james-p@moving-picture.com>
Subject: Re: [patch] umount loopback filessystems on autofs stop
Date: Fri, 03 Sep 2004 10:03:19 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <41383357.2000305@moving-picture.com>
References: <11395.1094160050@ichips.intel.com> <4137D77E.9080703@sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4137D77E.9080703@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs@linux.kernel.org

Mike Waychison wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Joseph V Moss wrote:
> 
>>Using /proc/mounts could be an issue for anyone trying to use this
> 
> with a kernel
> 
>>that truncates /proc/mounts.
>>
> 
> 
> Which kernel truncates /proc/mounts?
> 
> Any recent kernel uses the seq_file interface which guarantees that
> nothing gets truncated.  I have a system up and running that works fine
> with about 2500 mounts.


seq_file support for /proc/mounts was introduced with 2.4.19

James Pearson
