From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: nfs optimization settings in the automounter
Date: Tue, 18 Nov 2003 11:27:33 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FBA72A5.4050605@zytor.com>
References: <3FBA5C63.9080402@scout.wisc.edu> <3FBA67F7.1050505@zytor.com>
	<3FBA6B79.9080706@scout.wisc.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FBA6B79.9080706@scout.wisc.edu>
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
To: Justin Rush <jrush@scout.wisc.edu>
Cc: autofs@linux.kernel.org

Justin Rush wrote:
> I am using nfs v3 and I can mount it manually with these options.

If so, please enable *.debug output in syslog and look at the output
from the automounter in the syslog.

	-hpa
