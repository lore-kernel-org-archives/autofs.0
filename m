From: Justin Rush <jrush@scout.wisc.edu>
Subject: Re: nfs optimization settings in the automounter
Date: Tue, 18 Nov 2003 12:56:57 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FBA6B79.9080706@scout.wisc.edu>
References: <3FBA5C63.9080402@scout.wisc.edu> <3FBA67F7.1050505@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FBA67F7.1050505@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org

I am using nfs v3 and I can mount it manually with these options.

H. Peter Anvin wrote:

>Justin Rush wrote:
>  
>
>>I am having a hard time telling the automounter to use the options
>>rsize=32768,wsize=32768 when automounting home directories.  I have
>>tried specifying these options in the auto.home file on my nis master
>>server ( -rw,soft,rsize=32768,wsize=32768 nismaster:/export/home/jrush )
>>I have also tried to put them in the localoptions setting in the autofs
>>init file ( localoptions='rsize=32768,wsize=32768' ) on both the nis
>>master and on the client machines.
>>I also tried to specify these options in the auto.master file on the nis
>>master (the client machines don't have auto.master files because they
>>read the nis master's file ) ( /etc/auto.home 
>>--timeout=43200,rsize=32768,wsize=32768 )
>>I have also tried to use lower settings such as 16384
>>
>>however when I look in /proc/mounts on the client machine it is either
>>mounted with 4096 or 8192
>>
>>    
>>
>
>Are you using NFSv3?  As far as I know I think 8192 is max for NFSv2, at
>least for most of the NFSv2 servers I know.
>
>Try doing the mounting without using autofs.  If the same thing happens,
>it's an NFS issue, not an autofs issue.
>
>	-hpa
>  
>

-- 
Justin Rush
Technical Specialist
Internet Scout Project
jrush@scout.wisc.edu
