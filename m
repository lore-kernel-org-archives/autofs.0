From: "Takashi Yoshizawa" <mz711@hotmail.com>
Subject: What is the purpose of AUTOFS_NEGATIVE_TIMEOUT?
Date: Wed, 28 Jul 2004 19:03:12 +0900
Sender: autofs-bounces@linux.kernel.org
Message-ID: <BAY18-F10AKYVpMmOlb0000761f@hotmail.com>
Mime-Version: 1.0
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
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hi,

AUTOFS_NEGATIVE_TIMEOUT is defined in autofs_i.h.  I want to know this 
purpose.
In case of CD, "ls /mnt/cd/" without CD doesn't mount, and then insert CD,
"ls /mnt/cd/" doesn't too.  Why?  I want it mount immediately.

Regards,
Takashi Yoshizawa

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
