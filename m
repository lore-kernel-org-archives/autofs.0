From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: What is the purpose of AUTOFS_NEGATIVE_TIMEOUT?
Date: Mon, 09 Aug 2004 16:21:23 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <411806F3.3000906@zytor.com>
References: <BAY18-F10AKYVpMmOlb0000761f@hotmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BAY18-F10AKYVpMmOlb0000761f@hotmail.com>
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
To: Takashi Yoshizawa <mz711@hotmail.com>
Cc: autofs@linux.kernel.org

Takashi Yoshizawa wrote:
> Hi,
> 
> AUTOFS_NEGATIVE_TIMEOUT is defined in autofs_i.h.  I want to know this 
> purpose.
> In case of CD, "ls /mnt/cd/" without CD doesn't mount, and then insert CD,
> "ls /mnt/cd/" doesn't too.  Why?  I want it mount immediately.
> 

autofs is not the tool of choice for removable media.  A volume-insertion 
daemon is.

The reason for the negative timeout is to keep an unprivileged user from 
DoSing the system.

	-hpa
