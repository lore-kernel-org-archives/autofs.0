From: "Alan.Burke" <alan.burke@analog.com>
Subject: Strange autofs V4.0 problems
Date: Mon, 02 Feb 2004 15:51:15 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <401EB843.5000501@analog.com>
Reply-To: alan.burke@analog.com
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
To: autofs@linux.kernel.org
Cc: Annie Mckeon <anne.bourgeois@analog.com>

Hi Folks,

We're having a strange problem with autofs V4.1 on RH8.
I hope someone can help.

Can't connect to certain Network Appliances boxes.  No rhyme or reason.
Both /net and /home directories fail on some Net Apps but not others. The
Net App boxes are exporting correctly. We can mount the netapps, just not
via autofs.

Errors from the messages file...

Jan 29 15:36:54 cfl27 automount[19457]: mount(nfs): nfs: mount failure 
820ntap:/vol/vol1 on /net/820ntap/vol/vol1
Jan 29 15:36:54 cfl27 automount[19457]: failed to mount /net/820ntap
Jan 29 15:36:54 cfl27 automount[19467]: >> mount: 820ntap:/vol/vol1 
failed, reason given by server: Permission denied

Any Ideas?

Thanks in advance,

alan

-- 
Alan J. Burke		Engineering IS Manager
Analog Devices		Email: alan.burke@analog.com
