From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: [PATCH 1/5] use PATH
Date: Fri, 11 Feb 2005 11:58:01 +0200
Message-ID: <200502111158.01592.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Use exec*p() so that root can use PATH to direct automount
to desired mount binary and the like
--
vda
