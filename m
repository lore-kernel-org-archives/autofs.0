From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: To autofs4 or not
Date: Fri, 16 Apr 2004 10:39:45 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16511.61489.172219.152402@segfault.boston.redhat.com>
References: <407F1FBC.3060603@analog.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <407F1FBC.3060603@analog.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: alan.burke@analog.com
Cc: autofs@linux.kernel.org

==> Regarding [autofs] To autofs4 or not; "Alan.Burke" <alan.burke@analog.com> adds:

alan.burke> Hi Everyone, I have the task of convincing a team of admins
alan.burke> that we should be using autofs4 with RH8. /net is the major
alan.burke> reason I want to use it, but some claim RH does not support
alan.burke> autofs4. Is this true? If so will they support it in RHE3 or a
alan.burke> future version?

Well, RH8 is no longer supported, I'm sure you know.  :(  I've been working
to get the autofs4 user space into RHEL 3, so it will appear in the next
update release.  RHEL 4 will _hopefully_ support autofs4 user space and
kernel module.

Cheers,

Jeff
