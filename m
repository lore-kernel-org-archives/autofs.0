From: mmarion@qualcomm.com
Subject: Re: direct map shut down?
Date: Fri, 20 Feb 2004 16:37:15 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200402210037.i1L0bF3K004332@miguelito.qualcomm.com>
References: <Pine.LNX.4.58.0402202102020.4573@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402202102020.4573@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org

On 20 Feb, Ian Kent wrote:

> I thought that should be proto=tcp?

No, it's not required.  It'll support proto=, but tcp is the default.  In the
moutn man page it shows it as a boolean value/argument that can be proceeded
by no, as can udp.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
"But these are not inherent flaws in the operating system - they don't
happen by accident." - Mike Nash, "Director of Microsoft's Infrastructure
Systems" explaining why NT has so many patches to fix crashes caused by
malicious net users. 
