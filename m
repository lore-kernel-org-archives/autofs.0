From: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Subject: Re: making the mountpoints visible all the time
Date: Thu, 13 Nov 2003 12:29:38 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FB3E9B2.1090002@intel.com>
References: <3FB3C4C4.4030605@yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: Alexander Macdonald <alexandermacdonald@yahoo.com>
Cc: autofs@linux.kernel.org

Alexander Macdonald wrote:
> Hi
> 
> I've currently got automount setup so that i can cd into a directory 
> like /mnt/someplace and someplace will be automatically created and 
> mounted... it would be quite usefull if that directory was allways 
> visible so that i could browse to it in gui applications... how do i do 
> that?

If you want it visible all the time, use /etc/fstab, not autofs.  Work 
is being done on leaving the directory structure before actually 
mounting it, but it is not finished yet.

Forrest
-- 
