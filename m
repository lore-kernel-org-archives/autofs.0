From: "Stephen Biggs" <sbiggs@nvidia.com>
Subject: Re: Automounter stops mounting home directories.
Date: Thu, 19 Jun 2008 18:04:47 -0700
Message-ID: <A2ECBF49F352C24F9DF65BB529DCBC70187A5769@hqemmail01.nvidia.com>
References: <A2ECBF49F352C24F9DF65BB529DCBC7014E02D1D@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <A2ECBF49F352C24F9DF65BB529DCBC7014E02D1D@hqemmail01.nvidia.com>
Content-class: urn:content-classes:message
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
To: autofs@linux.kernel.org
Cc: Ian Kent <raven@themaw.net>

Yes, after some further code diving, I realize now what I have already
realized before that Ian's IOCTL method patches should take care of this
issue for us most handily. I and Ian have already discussed this in
email. Sorry for the redundancy and noise on the list.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
