From: "Takashi Yoshizawa" <mz711@hotmail.com>
Subject: Re: What is the purpose of AUTOFS_NEGATIVE_TIMEOUT?
Date: Wed, 11 Aug 2004 14:27:10 +0900
Sender: autofs-bounces@linux.kernel.org
Message-ID: <BAY18-F41cm9t0CI76r000276b9@hotmail.com>
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
To: hpa@zytor.com
Cc: autofs@linux.kernel.org

H. Peter Anvin wrote:
>autofs is not the tool of choice for removable media.  A volume-insertion 
>daemon is.
>
>The reason for the negative timeout is to keep an unprivileged user from 
>DoSing the system.

I understand.
Thank you.

Takashi Yoshizawa

_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*. 
http://join.msn.com/?page=features/virus
